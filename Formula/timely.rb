class Timely < Formula
  desc "A lightweight, agent-friendly activity tracker for macOS"
  homepage "https://github.com/Bhavikpatel576/timely"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-arm64-apple-darwin.tar.gz"
      sha256 "e436cc6f51e3e5bfb3764f17da95e4c41278d1a40c960d72bf87ddc67a15063b"
    else
      url "https://github.com/Bhavikpatel576/timely/releases/download/v#{version}/timely-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "08cc524ec227f12c421ecfdef6dc12c5bc98cad370d213f6db614e3469c60a6e"
    end
  end

  depends_on :macos

  def install
    # The tarball contains Timely.app bundle
    prefix.install "Timely.app"
    bin.write_exec_script prefix/"Timely.app/Contents/MacOS/timely"
  end

  def caveats
    <<~EOS
      Timely requires Accessibility permissions to track window activity.

      After installing, grant access:
        1. Open System Settings > Privacy & Security > Accessibility
        2. Click '+' and add Timely (or the terminal you run it from)

      Start the background daemon:
        timely daemon start

      The daemon will start automatically on login via launchd.
    EOS
  end

  test do
    assert_match "timely", shell_output("#{bin}/timely --help")
  end
end
