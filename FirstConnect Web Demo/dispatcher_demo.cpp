#include <iostream>
#include <string>
#include <functional>
#include <chrono>
#include <thread>
#include <cmath>

struct DispatchConfig {
    std::string responderLabel = "Police unit #22"; // e.g., "Police unit #22"
    std::string etaInitial = "3:24 PM";             // shown at dispatch + 10-mile update
    std::string etaUpdated = "3:22 PM";             // shown at 5-mile + 1-mile updates (fallbacks to initial if empty)
    bool locationSharingEnabled = true;             // if false, distance-based updates are skipped
};

class DispatcherAutoMessenger {
public:
    DispatcherAutoMessenger(DispatchConfig cfg,
                            std::function<void(const std::string&)> uiSendFn)
        : cfg_(std::move(cfg)), uiSend_(std::move(uiSendFn)) {}

    // #2 Dispatcher Leaving Station (ETA sent)
    void sendEnRoute(double initialDistanceMiles) {
        if (sentEnRoute_) return;
        sentEnRoute_ = true;

        uiSend_(cfg_.responderLabel + " en route. Estimated arrival is "
                + cfg_.etaInitial + " (" + formatMiles(initialDistanceMiles)
                + " away). Please keep your phone nearby for updates.");
    }

    // Feed this with your live distance-to-caller
    void onDistanceUpdate(double milesRemaining) {
        if (!cfg_.locationSharingEnabled) return;

        // #3 10 Mile Away Update
        if (!sent10_ && milesRemaining <= 10.0) {
            sent10_ = true;
            uiSend_("Estimated arrival is " + cfg_.etaInitial
                    + ". Responder is on the way, currently 10 miles out. "
                      "Text here anytime with updates or concerns.");
        }

        // #4 5 Miles Away Update
        if (!sent5_ && milesRemaining <= 5.0) {
            sent5_ = true;
            const std::string eta = cfg_.etaUpdated.empty() ? cfg_.etaInitial : cfg_.etaUpdated;
            uiSend_("Updated estimated arrival time is " + eta
                    + ". Your assigned responder is 5 miles away. "
                      "Please make sure the entrance is visible/unlocked if it is safe to do so.");
        }

        // #5 1 Mile Away Update
        if (!sent1_ && milesRemaining <= 1.0) {
            sent1_ = true;
            const std::string eta = cfg_.etaUpdated.empty() ? cfg_.etaInitial : cfg_.etaUpdated;
            uiSend_("Estimated arrival time is " + eta
                    + ". Responder is 1 mile out. Please prepare to meet them.");
        }

        // #6 Arrival Notification (treat ≤0.1 mi as arrival)
        if (!sentArrive_ && milesRemaining <= 0.1) {
            sentArrive_ = true;
            uiSend_("Responder has arrived on scene. Entering main doors.");
        }
    }

private:
    static std::string formatMiles(double miles) {
        // round to whole miles for this copy; adjust if you need decimals
        long rounded = static_cast<long>(std::llround(miles));
        return std::to_string(rounded) + " miles";
    }

    DispatchConfig cfg_;
    std::function<void(const std::string&)> uiSend_;
    bool sentEnRoute_ = false, sent10_ = false, sent5_ = false, sent1_ = false, sentArrive_ = false;
};

// -------- Demo harness (replace with your app wiring) --------
int main() {
    auto sendToUI = [](const std::string& msg) {
        // Replace with: append to chat, trigger push, etc.
        std::cout << "[DISPATCH TEXT] " << msg << "\n";
    };

    DispatchConfig cfg;
    cfg.responderLabel = "Police unit #22";
    cfg.etaInitial = "3:24 PM";
    cfg.etaUpdated = "3:22 PM";

    DispatcherAutoMessenger dam(cfg, sendToUI);

    // #2 En route (initial distance must match your tracker; using 15 mi to match your copy)
    dam.sendEnRoute(15.0);

    // Simulated distance updates (feed your live values here)
    double distances[] = {12.0, 10.0, 7.4, 5.0, 1.0, 0.08};
    for (double d : distances) {
        dam.onDistanceUpdate(d);
        std::this_thread::sleep_for(std::chrono::milliseconds(400)); // pacing for demo
    }

    return 0;
}
