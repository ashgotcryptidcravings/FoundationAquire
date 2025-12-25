import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var profile: AppProfile
    @EnvironmentObject private var performance: PerformanceProfile
    @EnvironmentObject private var telemetry: Telemetry
    
    var body: some View {
        VStack(spacing: 14) {
            ForEach(AppProfile.UserExperience.allCases) { exp in
                Button {
                    profile.experience = exp
                } label: {
                    HStack(spacing: 14) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exp.title)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text(exp.subtitle)
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        if profile.experience == exp {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.purple)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.white.opacity(0.25))
                        }
                    }
                    .padding(16)
                }
            }
            .padding(.horizontal, 18)
            
            VStack(spacing: 10) {
                Toggle(isOn: $profile.telemetryOptIn) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Share anonymous performance logs")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                        
                        Text("Only stores app events locally for now.")
                            .foregroundColor(.white.opacity(0.65))
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                    }
                }
                .toggleStyle(.switch)
                .tint(.purple)
                .padding(.horizontal, 18)
                
                Button {
                    profile.hasCompletedOnboarding = true
                    telemetry.log("onboarding_complete",
                                  source: "experience=\(profile.experience.rawValue), lowPower=\(performance.isLowPowerMode)")
                } label: {
                    Text("Continue")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
            }
        }
    }
}
