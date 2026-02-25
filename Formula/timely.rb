class Timely < Formula
  desc "A lightweight, agent-friendly activity tracker for macOS"
  homepage "https://github.com/Bhavikpatel576/timely"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-arm64-apple-darwin-bin.tar.gz"
      sha256 "5a9718cb2aac791d8f1f9d9129288c0df9dfeac4f92006338ffc0e65e82b34cc"
    else
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-x86_64-apple-darwin-bin.tar.gz"
      sha256 "ca63bf430d8861c9cfa50a2700952e5359c521f370e1ae571a8d9d76a92c3a26"
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
