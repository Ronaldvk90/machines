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

  age.secrets.wg0 = {
    file = ../../secrets/wg0.age;
  };

  age.secrets.debbieOpenvpn = {
    file = ../../secrets/debbie.openvpn.credentials.age;
  };
}