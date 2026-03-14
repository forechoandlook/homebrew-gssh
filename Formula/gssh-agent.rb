class GsshAgent < Formula
  desc "SSH Session Manager for Agents"
  homepage "https://github.com/forechoandlook/gssh"
  license "MIT"
  version "1.0.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/forechoandlook/gssh/releases/download/v1.0.0/gssh-darwin-arm64.tar.gz"
      sha256 "6d10b8cad1384a326e85f9389f295103031a7102b6c1702a413101e3e134c369"
    else
      url "https://github.com/forechoandlook/gssh/releases/download/v1.0.0/gssh-darwin-amd64.tar.gz"
      sha256 "TODO: update with actual sha256 for amd64"
    end
  end

  def install
    bin.install "gssh"
    bin.install "gssh-daemon"
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
              <string>#{opt_bin}/gssh-daemon</string>
              <string>-socket</string>
              <string>/tmp/gssh.sock</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <true/>
          <key>StandardOutPath</key>
          <string>#{var}/log/gssh.log</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/gssh.error.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    system "#{bin}/gssh", "--help"
  end
end
