class KillServer < Formula
    desc "A script to kill a server running on a specified port"
    homepage "https://github.com/mj-963/kill-server"
    url "https://github.com/mj-963/kill-server/archive/v1.0.0.tar.gz"
    sha256 "f1d3b865bad85013dab900d4dd6c9fbe42ca84d55e4d2013bb3db07c8ef33f79"
  
    def install
      bin.install "kill-server.sh" => "kill-server"
    end
  
    test do
      system "#{bin}/kill-server", "--version"
    end
  end
  