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
}