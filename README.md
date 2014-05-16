# Vagrant with serverspec for practice


## Requirements

- Ruby
- Git
- Vagrant
- vagrant-omnibus(plugin)
- ssh client(Windows)

## Setup

```
bundle
librarian-chef install
vagrant plugin install vagrant-omnibus
```

### Hint for Windows

Install requements using chocolatey.

> [https://chocolatey.org/](https://chocolatey.org/)

or 

> http://rubyinstaller.org/downloads/  
> http://code.google.com/p/msysgit/

Install vagrant-proxyconf if need.

vagrant plugin install vagrant-proxyconf

----

Create serverspec VM.

```
vagrant up serverspec
```

Create test target VM as sandbox.

```
vagrant up sandbox
```

## Usage

### Chef

Create cookbook for sandbox.

```
knife cookbook create hogehoge -o site-cookbooks/
```

Add your recipe to run_list.

```
chef.add_recipe 'recipe[hogehoge::default]'
```

### Serverspec

copy Vagrant `insecure_private_key` to tmp/.

```
cp ~/.vagrant.d/insecure_private_key tmp/
```

or `$HOME\.vagrant.d\insecure_private_key` (Microsofrt Windows)


logg in to serverspec VM.

```
vagrant ssh serverspec
```

Add `insecure_private_key` to ssh-agent

```
eval `ssh-agent`
ssh-add /vagrant/tmp/insecure_private_key 
```

Execute `serverspec-init`, default ipaddress of sandbox is '10.33.34.101'.

```
$ mkdir -p /vagrant/tmp/serverspec
$ cd /vagrant/tmp/serverspec
$ serverspec-init
Select OS type:

  1) UN*X
  2) Windows

Select number: 1

Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 1

Vagrant instance y/n: n
Input target host name: 10.33.34.101
 + spec/
 + spec/10.33.34.101/
 + spec/10.33.34.101/httpd_spec.rb
 + spec/spec_helper.rb
 + Rakefile
```



## LICENCE

free

Author: SAWANOBORI Yuihiko <sawanoboriyu@higanworks.com>
