class Timely < Formula
  desc "A lightweight, agent-friendly activity tracker for macOS"
  homepage "https://github.com/Bhavikpatel576/timely"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-arm64-apple-darwin-bin.tar.gz"
      sha256 "39b00cdd9b33de8c725cbaaba75abd13c6e23b463b5b8948e1680f89398594ae"
    else
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-x86_64-apple-darwin-bin.tar.gz"
      sha256 "16d2fc8924b717d4584a8cfab7e06a72418f4de30c4303bf41177fe616eae827"
    end
  end

  depends_on :macos

  def install
    bin.install "timely"
  end

  def caveats
    <<~EOS
      Timely requires Accessibility permissions to track window activity.

      After installing, grant access:
        1. Open System Settings > Privacy & Security > Accessibility
        2. Click '+' and add the terminal you run timely from

      Start the background daemon:
        timely daemon start

      The daemon will start automatically on login via launchd.
    EOS
  end

  test do
    assert_match "timely", shell_output("#{bin}/timely --help")
  end
end
