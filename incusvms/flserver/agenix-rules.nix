let
  admin = "age18lrtstkkarzvcycz934a05cfzn4npeq03lhfyr9eakx6quq5esqspqn4ne";
in
{

################ SSH keys #######################

  "ssh_host_ed25519_key.age".publicKeys = [           
    admin
  ];

  "ssh_host_rsa_key.age".publicKeys = [           
    admin
  ];
##################################################
}
