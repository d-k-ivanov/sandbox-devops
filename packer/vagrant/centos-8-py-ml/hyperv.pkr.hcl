variable "box_version" {
    type                                = string
    default                             = "${env("VERSION")}"
}

source "hyperv-iso" "centos8-hyperv" {
    boot_command                        = ["<tab>text biosdevname=0 net.ifnames=0 ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/generic.centos8.vagrant.ks<enter><wait>"]
    boot_keygroup_interval              = "1s"
    boot_wait                           = "20s"
    communicator                        = "ssh"
    cpus                                = 2
    disk_size                           = 131072
    enable_dynamic_memory               = false
    enable_mac_spoofing                 = false
    enable_secure_boot                  = false
    enable_virtualization_extensions    = false
    generation                          = 1
    guest_additions_mode                = "disable"
    headless                            = true
    http_directory                      = "http"
    iso_checksum                        = "sha256:0394ecfa994db75efc1413207d2e5ac67af4f6685b3b896e2837c682221fd6b2"
    iso_url                             = "https://mirrors.edge.kernel.org/centos/8.4.2105/isos/x86_64/CentOS-8.4.2105-x86_64-dvd1.iso"
    memory                              = 2048
    output_directory                    = "output/centos8-hyperv"
    shutdown_command                    = "echo 'vagrant' | sudo -S shutdown -P now"
    skip_compaction                     = false
    ssh_password                        = "vagrant"
    ssh_port                            = 22
    ssh_timeout                         = "7200s"
    ssh_username                        = "root"
    temp_path                           = "output/"
    vm_name                             = "centos8-hyperv"
}

build {
    sources                             = ["source.hyperv-iso.centos8-hyperv"]

    provisioner "shell" {
        execute_command                 = "{{ .Vars }} /bin/bash '{{ .Path }}'"
        expect_disconnect               = "true"
        only                            = ["centos8-hyperv"]
        pause_before                    = "2m0s"
        scripts                         = [
            "scripts/kernel.sh",
            "scripts/floppy.sh",
            "scripts/virtualbox.sh",
            "scripts/parallels.sh",
            "scripts/vmware.sh",
            "scripts/qemu.sh",
            "scripts/vagrant.sh",
            "scripts/tuning.sh",
            "scripts/sshd.sh",
            "scripts/randomness.sh",
            "scripts/updatedb.sh",
            "scripts/cleanup.sh",
            "scripts/undnf.sh"
        ]
        start_retry_timeout             = "45m"
        timeout                         = "2h0m0s"
    }

    provisioner "shell" {
        expect_disconnect               = "true"
        scripts                         = [
            "scripts/motd.sh",
            "scripts/keys.sh",
            "scripts/machine.sh",
            "scripts/leases.sh",
            "scripts/localtime.sh",
            "scripts/zerodisk.sh",
            "scripts/lockout.sh"
        ]
        start_retry_timeout             = "45m"
        timeout                         = "2h0m0s"
    }


    post-processors {
        post-processor "vagrant" {
            keep_input_artifact         = false
            compression_level           = 9
            include                     = ["tpl/generic/info.json"]
            output                      = "output/{{split build_name \"-\" 1}}-{{split build_name \"-\" 2}}-{{user `box_version`}}.box"
            vagrantfile_template        = "tpl/{{split build_name \"-\" 1}}.rb"
        }
        post-processor "checksum" {
            keep_input_artifact         = false
            checksum_types              = ["sha256"]
            output                      = "output/{{split build_name \"-\" 1}}-{{split build_name \"-\" 2}}-{{user `box_version`}}.box.sha256"
        }
    }

    # could not parse template for following block: "template: hcl2_upgrade:6: unexpected \"\\\\\" in operand"
    post-processors {
        post-processor "vagrant" {
            keep_input_artifact         = false
            compression_level           = 9
            include                     = ["tpl/roboxes/info.json"]
            output                      = "output/roboxes-{{split build_name \"-\" 1}}-{{split build_name \"-\" 2}}-{{user `box_version`}}.box"
            vagrantfile_template        = "tpl/roboxes-{{split build_name \"-\" 1}}.rb"
        }
        post-processor "checksum" {
            keep_input_artifact         = false
            checksum_types              = ["sha256"]
            output                      = "output/roboxes-{{split build_name \"-\" 1}}-{{split build_name \"-\" 2}}-{{user `box_version`}}.box.sha256"
        }
    }
}
