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

  "ronald.openvpn.credentials.age".publicKeys = [
    admin
  ];

  "wg0.biff.age".publicKeys = [
    admin
  ];

  "wg0.werkplaats.age".publicKeys = [
    admin
  ];

  "wg0.debbie-laptop.age".publicKeys = [
    admin
  ];

  "debbie.openvpn.credentials.age".publicKeys = [
    admin
  ];

  "bttf.lan.nmconnection.age".publicKeys = [
    admin
  ];

  "Ziggo-ap-4d4efe6.nmconnection.age".publicKeys = [           
    admin
  ];
}
