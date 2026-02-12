class Timely < Formula
  desc "A lightweight, agent-friendly activity tracker for macOS"
  homepage "https://github.com/Bhavikpatel576/timely"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-arm64-apple-darwin-bin.tar.gz"
      sha256 "bbaa6c63ec2074e9d349d978bca0cf55b7557953f418ba45542dfb30fbce552a"
    else
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-x86_64-apple-darwin-bin.tar.gz"
      sha256 "0fb0151183aaba9938fc185254b5536a09ae0e7d1757665d94f31102e68b1962"
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
