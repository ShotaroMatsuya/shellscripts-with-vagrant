## Create Your First Vagrant Project

To create the Vagrant configuration file (Vagrantfile), run the "vagrant init <BOX_NAME>" command. Be sure to be in Vagrant project directory you just created. Also, use the "jasonc/centos7" box you downloaded earlier.

```
cd testbox01

vagrant init jasonc/centos7
```

## Create Your First Virtual Machine

The first time you run the "vagrant up" command Vagrant will import (clone) the vagrant box into VirtualBox and start it. If Vagrant detects that the virtual machine already exists in VirtualBox it will simply start it. By default, when the virtual machine is started, it is started in headless mode meaning there is no UI for the machine visible on your local host machine.

Let’s bring up your first virtual machine running Linux with Vagrant.

```
vagrant up
```

## Troubleshooting

On some systems you may see the following message, though it is rare.

Timed out while waiting for the machine to boot. This means that

Vagrant was unable to communicate with the guest machine within

the configured ("config.vm.boot_timeout" value) time period.

If you look above, you should be able to see the error(s) that

Vagrant had when attempting to connect to the machine. These errors

are usually good hints as to what may be wrong.

If you're using a custom box, make sure that networking is properly

working and you're able to connect to the machine. It is a common

problem that networking isn't setup properly in these boxes.

Verify that authentication configurations are also setup properly,

as well.

If the box appears to be booting properly, you may want to increase

the timeout ("config.vm.boot_timeout") value.

If you do see that message it most likely means the virtual machine started with its networking interface disabled. To force the network interface to be enabled we'll need to update the Vagrantfile. The Vagrantfile controls the behavior and settings of the virtual machine. Open it with your favorite text editor. You may need to use the File Explorer (Windows) or the Finder (Mac) to navigate to the folder and then open it with your desired editor.

By the way, Atom is a nice text editor that works on Mac, Windows, and even Linux. You can download it for free at Atom.io.

Add the following line somewhere after "Vagrant.configure(2) do |config|" and before "end". A good place could be right after the 'config.vm.box = "jasonc/centos7"' line:

```
config.vm.provider "virtualbox" do |vb|
vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
end
```

Reboot the virtual machine with Vagrant.

```
vagrant reload
```

## Confirm That It's Running

Start the VirtualBox application. On Windows double click on the "Oracle VM VirtualBox" icon on your desktop. For Mac users, start the /Applications/VirtualBox application. Linux users will need to find the application in their menuing system.

Confirm that you see a virtual machine running. It will start with the name of your Vagrant project folder.

You can also use the "vagrant status" command to check the status of the virtual machine. Confirm that it shows the virtual machine is in a running state.

```
vagrant status
```

## Connect to the Virtual Machine

SSH, secure shell, is the network protocol used to connect to Linux systems. Vagrant provides a nice shortcut to ssh into the virtual machine.

```
vagrant ssh
```

Now you are connected to the Linux virtual machine as the vagrant user. This default vagrant account is used to connect to the Linux system. For your convenience, the Vagrant application takes care of the details that allow you to connect to the box over SSH without a password. For reference, the password for the vagrant account is "vagrant". The password for the root account is also "vagrant". The vagrant user has full sudo (administrative) privileges that allow you to further configure the system. You will learn more about accounts, privileges, and sudo later in this course.

After running "vagrant ssh" you should be presented with a prompt that looks similar to this:

```
[vagrant@localhost ~]$
```

You'll be working a lot at the Linux command line in this course. For now, let’s log out of the Linux system by running the "exit" command.

```
exit
```

## Stop the Virtual Machine

The "vagrant halt" command shuts down the virtual machine. When you run this command you will not lose any work you’ve performed on the virtual machine. The virtual machine will still exist in VirtualBox, it will simply be stopped.

```
vagrant halt
```

## Open the VirtualBox application and verify that the virtual machine is still define, yet stopped.

Start the Virtual Machine Again
Remember, to start the virtual machine run "vagrant up". This time when you run the command it will not need to import the box image into VirtualBox as the virtual machine already exists.

Switch back to the command line on your local machine and run the following command.

```
vagrant up
```

Open the VirtualBox application and verify that the virtual machine is now running.

## Change the Virtual Machine's Name

The Vagrantfile controls the behavior and settings of the virtual machine. Open it with your favorite text editor. You may need to use the File Explorer (Windows) or the Finder (Mac) to navigate to the folder and then open it with your desired editor.

By the way, Atom is a nice text editor that works on Mac, Windows, and even Linux. You can download it for free at Atom.io.

Add the following line somewhere after "Vagrant.configure(2) do |config|" and before "end". A good place could be right after the 'config.vm.box = "jasonc/centos7"' line:

```
config.vm.hostname = "testbox01"
```

Be sure to save your changes.

At this point you could run "vagrant halt" followed by "vagrant up" to activate this change. However, Vagrant provides a shortcut: "vagrant reload" which restarts the virtual machine, loads the new Vagrantfile configuration, and starts the virtual machine again. Give it a go:

```
vagrant reload
```

Connect to the virtual machine to confirm that it's hostname has changed.

```
vagrant ssh
```

You should see a prompt similar to this one containing the hostname that you configured:

```
[vagrant@testbox01 ~]$
```

Disconnect from the virtual machine:

```
$ exit
```

## Assign the Virtual Machine an IP Address

During this course you are going to create virtual machines that will be able to communicate with each other as well as your local workstation. Let's give this virtual machine the IP address of "10.9.8.7". To do that, insert the following line of configuration into the Vagrantfile. Remember, it needs to be inserted somewhere after "Vagrant.configure(2) do |config|" and before "end".

```
config.vm.network "private_network", ip: "10.9.8.7"
```

Save your changes.

Reload the virtual machine and let Vagrant assign the IP address to it.

```
vagrant reload
```

Test the connection by pinging the virtual machine.

Mac and Linux users, run the following command:

```
ping -c 3 10.9.8.7
```

The ping command is one simple way to test network connectivity. If you see replies, then you can safely assume the IP address is reachable and the host is up. If you see "timeout" messages then the system is not answering your ping requests. In the "real world" this doesn't necessarily mean the system is "down." It means it is not answering your ping requests which could be for a variety of reasons. However, for our purposes here if you get "timeout" messages, then you can assume this system is down or something is wrong. The first thing to try is to simply reboot the VM by running:

```
vagrant reload
```

If the ping command fails again, double check the contents of the Vagrantfile paying special attention to the config.vm.network line. Make any necessary changes, restart the virtual machine and try again.

The final step is to reboot the host operating system, I.E. your physical computer. This troubleshooting step primarily applies to Windows users.

## Destroy the Virtual Machine

If you’re are done with the virtual machine or you want to start over with a fresh copy of the virtual machine, run "vagrant destroy".

```
vagrant destroy
```

It will prompt you to confirm that you want to delete the virtual machine. Answer "y". If the virtual machine is running it will stop it and then delete it. If it’s already stopped, it will simply delete it.

## Final Vagrantfile for testbox01

Here are the contents of the shellclass/testbox01/Vagrantfile file with all the comments removed.

```
Vagrant.configure(2) do |config|
config.vm.box = "jasonc/centos7"
config.vm.hostname = "testbox01"
config.vm.network "private_network", ip: "10.9.8.7"
end
```

Create Another Vagrant Project with Multiple Virtual Machines
Let’s create another Vagrant Project and two virtual machines. First, let’s return to our "shellclass" directory. The "cd .." command changes to the parent directory which is represented by "..".

```
cd ..
```

Next, let’s create the Vagrant project folder and change into that folder.

```
mkdir multitest
cd multitest
```

Initialize the Vagrant project. This step creates the Vagrantfile.

```
vagrant init jasonc/centos7
```

Add two virtual machine definitions. The first host definition will define the test1 VM with a hostname of "test1" and an IP address of 10.9.8.5. The second host definition will define the test2 VM with a hostname of "test2" and an IP address of 10.9.8.6. Here are the contents of the shellclass/multitest/Vagrantfile file with all the comments removed.

```
Vagrant.configure("2") do |config|
    config.vm.box = "jasonc/centos7"
    config.vm.define "test1" do |test1|
        test1.vm.hostname = "test1"
        test1.vm.network "private_network", ip: "10.9.8.5"
    end
    config.vm.define "test2" do |test2|
        test2.vm.hostname = "test2"
        test2.vm.network "private_network", ip: "10.9.8.6"
    end
end
```

Start the virtual machines. (Remember, that if you do not specify a VM name all the defined VMs will be started.)

```
vagrant up
```

Check their status with the following command:

```
vagrant status
```

Connect to the test1 virtual machine to confirm that it’s working and then exit it.

```
vagrant ssh test1
$ exit
```

Connect to the test2 virtual machine to confirm that it’s working. While you are logged into the test2 VM, ping the test1 VM to prove that the two virtual machines can communicate with each other over the network.

```
vagrant ssh test2
ping -c 3 10.9.8.5
```

When you brought up the virtual machines you may have noticed a message similar to this one:

==> test2: Mounting shared folders...

test2: /vagrant => /Users/jason/shellclass/multitest

You can access the files in the vagrant project directory that resides on your local machine inside the virtual machine. The vagrant project directory is mounted, or shared, via the /vagrant directory. The only file in our local directory is the Vagrantfile. You can look at the file from within the vm. Run the following commands while you're still logged into the test2 VM:

```
ls /vagrant
cat /vagrant/Vagrantfile
```

Exit out of the test2 VM.

```
exit
```

## Stop the Virtual Machines

In upcoming projects you'll be working more with Vagrant, virtual machines, IP addresses and more. Feel free to explore the Linux system if you'd like. (Connect by running "vagrant ssh [VM_NAME]" within the project folder.) When you're ready to stop or take a break, halt the virtual machine. Remember, you can always pick up where you left off as long as you don't destroy the virtual machine.

```
vagrant halt
```
# shellscripts-with-vagrant
