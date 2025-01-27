{ lib
, fetchFromGitHub
, buildGoModule
, testers
, gh-dash
}:

buildGoModule rec {
  pname = "gh-dash";
  version = "3.7.7";

  src = fetchFromGitHub {
    owner = "dlvhdr";
    repo = "gh-dash";
    rev = "v${version}";
    hash = "sha256-Ih9Vdt/ds8f37n7onWhvfrgMrE2iXQPwSTgxrui5TYY=";
  };

  vendorHash = "sha256-ZpX+0AyHFWOb75jlIS5/BqKpRkqNpE4SkOJ01CqO/0w=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/dlvhdr/gh-dash/cmd.Version=${version}"
  ];

  passthru.tests = {
    version = testers.testVersion { package = gh-dash; };
  };

  meta = {
    description = "gh extension to display a dashboard with pull requests and issues";
    homepage = "https://github.com/dlvhdr/gh-dash";
    changelog = "https://github.com/dlvhdr/gh-dash/releases/tag/${src.rev}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ amesgen ];
  };
}
