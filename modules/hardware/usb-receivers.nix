# Rebind Logitech receivers so they appear as if replugged when detected

{ pkgs, ... }:
{

  services.udev.extraRules = ''
    # Logitech Lightspeed (046d:c539)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c539", \
      RUN+="/bin/sh -c 'echo -n $kernel > /sys/bus/usb/drivers/usbhid/unbind; sleep 0.5; echo -n $kernel > /sys/bus/usb/drivers/usbhid/bind'"

    # Logitech USB Receiver (046d:c545)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c545", \
      RUN+="/bin/sh -c 'echo -n $kernel > /sys/bus/usb/drivers/usbhid/unbind; sleep 0.5; echo -n $kernel > /sys/bus/usb/drivers/usbhid/bind'"
  '';

  systemd.services."input-retrigger-after-dm" = {
  description = "Retrigger input devices after display manager starts";
  after = [ "display-manager.service" ];
  wants = [ "display-manager.service" ];
  serviceConfig = {
    Type = "oneshot";
    ExecStart = [
      "${pkgs.udev}/bin/udevadm control --reload"
      # retrigger only input subsystem; fast, no sleeps
      "${pkgs.udev}/bin/udevadm trigger --subsystem-match=input --action=add"
    ];
  };
  wantedBy = [ "multi-user.target" ];
};

}

