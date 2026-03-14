class GsshAgent < Formula
  desc "SSH Session Manager for Agents"
  homepage "https://github.com/forechoandlook/gssh"
  license "MIT"
  version "1.0.0"

  # Build from source (no download issues)
  url "https://github.com/forechoandlook/gssh.git", tag: "v1.0.0", revision: "723537c"

  depends_on "go" => :build

  def install
    # Build CLI
    system "go", "build", "-o", "bin/gssh", "cmd/gssh/main.go"
    # Build daemon
    system "go", "build", "-o", "bin/gssh-daemon", "cmd/daemon/main.go"

    bin.install "bin/gssh"
    bin.install "bin/gssh-daemon"
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
