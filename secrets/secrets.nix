let
  admin = "age18lrtstkkarzvcycz934a05cfzn4npeq03lhfyr9eakx6quq5esqspqn4ne";

in
{
  "ronald.password.age".publicKeys = [
    admin
  ];

  "debbie.password.age".publicKeys = [
    admin
  ];

  "ronald.nas.credentials.age".publicKeys = [
    admin
  ];

  "debbie.nas.credentials.age".publicKeys = [
    admin
  ];
}