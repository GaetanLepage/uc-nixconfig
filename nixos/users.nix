{
  users = {
    mutableUsers = false;

    users = let
      hashedPassword = "$y$j9T$5cQHoXnhWD5GDPL0e9Jgs0$xSTTG1TbR3tX7HkzhsgXXsa3vsHmDimnbsVnqd.YhN0";
    in {
      root = {
        isSystemUser = true;

        inherit hashedPassword;
      };

      uc = {
        isNormalUser = true;

        # Enable ‘sudo’ for the user.
        extraGroups = ["wheel"];

        inherit hashedPassword;
      };
    };
  };

  # Members of group wheel can execute sudo commands without password.
  security.sudo.wheelNeedsPassword = false;
}
