{
  age.identityPaths = [
    "/var/lib/agenix/agenix.key"
  ];

  age.secrets.ronaldNasCredentials = {
    file = ../../secrets/ronald.nas.credentials.age;
  };

  age.secrets.debbieNasCredentials = {
    file = ../../secrets/debbie.nas.credentials.age;
  };
}