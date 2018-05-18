class CodacyAnalysisCli < Formula
  desc "Codacy Analysis CLI"
  homepage "https://github.com/codacy/codacy-analysis-cli"
  url "https://github.com/codacy/codacy-analysis-cli/archive/v0.1.0-alpha2.27.tar.gz"
  sha256 "0938aafc46f61f6ba7b89dc74d76b950a2638f2839a66ce0cc58b136b494edbe"

  head "https://github.com/codacy/codacy-analysis-cli.git"

  def install
    # Alter PATH to ensure `docker' is available
    if Formula["docker"].linked_keg.exist?
      ENV.prepend_path "PATH", Formula["docker"].opt_bin
    else
      ENV.prepend_path "PATH", "/usr/local/bin"
    end

    ENV["PREFIX"] = prefix

    system "make", "install"
  end

  test do
    system "codacy-analysis-cli"
  end
end
