{
  age.identityPaths = [
    "/var/lib/agenix/agenix.key"
  ];

  age.secrets.ronaldPassword = {
    file = ../../secrets/ronald.password.age;
  };

  age.secrets.debbiePassword = {
    file = ../../secrets/debbie.password.age;
  };

  age.secrets.ronaldNasCredentials = {
    file = ../../secrets/ronald.nas.credentials.age;
  };

  age.secrets.debbieNasCredentials = {
    file = ../../secrets/debbie.nas.credentials.age;
  };

  age.secrets.ronaldOpenvpn = {
    file = ../../secrets/ronald.openvpn.credentials.age;
  };

  age.secrets.bttf-lan = {
   file = ../../secrets/bttf.lan.nmconnection.age;
   path = "/etc/NetworkManager/system-connections/bttf.lan.nmconnection";
  };

  age.secrets.Ziggo-ap-4d4efe6 = {
   file = ../../secrets/Ziggo-ap-4d4efe6.nmconnection.age;
   path = "/etc/NetworkManager/system-connections/Ziggo-ap-4d4efe6.nmconnection";
  };
}