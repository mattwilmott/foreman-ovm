# Foreman Oracle VM Plugin

[![Code Climate](https://codeclimate.com/github/mattwilmott/foreman-ovm/badges/gpa.svg)](https://codeclimate.com/github/mattwilmott/foreman-ovm)
[![Gem Version](https://badge.fury.io/rb/foreman_ovm.svg)](https://badge.fury.io/rb/foreman_ovm)
[![Dependency Status](https://gemnasium.com/badges/github.com/mattwilmott/foreman-ovm.svg)](https://gemnasium.com/github.com/mattwilmott/foreman-ovm)

```foreman-ovm``` enables provisioning and managing of [Oracle VM](https://www.oracle.com/virtualization/vm-server-for-x86/index.html) instances in [Foreman](http://github.com/theforeman/foreman), all of that under the GPL v3+ license.

* Website: [TheForeman.org](http://theforeman.org)
* ServerFault tag: [Foreman](http://serverfault.com/questions/tagged/foreman)
* Issues: [foreman-ovm Github Issues](http://www.github.com/mattwilmott/foreman-ovm/issues)
* Wiki: [Foreman wiki](http://projects.theforeman.org/projects/foreman/wiki/About)
* Community and support: #theforeman for general support, #theforeman-dev for development chat in [Freenode](irc.freenode.net)
* Mailing lists:
    * [foreman-users](https://groups.google.com/forum/?fromgroups#!forum/foreman-users)
    * [foreman-dev](https://groups.google.com/forum/?fromgroups#!forum/foreman-dev)


## WARNING

This gem is likely broken until version 0.1.x. It is currently undergoing heavy development

## Installation

Please see the Foreman manual for appropriate instructions:

* [Foreman: How to Install a Plugin](http://theforeman.org/manuals/latest/index.html#6.1InstallaPlugin)

### Red Hat, CentOS, Fedora, Scientific Linux (rpm)

Set up the repo as explained in the link above, then run

    # yum install ruby193-rubygem-foreman_ovm

### Debian, Ubuntu (deb)

Set up the repo as explained in the link above, then run

    # apt-get install ruby-foreman-ovm

### Bundle (gem)

Add the following to bundler.d/Gemfile.local.rb in your Foreman installation directory (/usr/share/foreman by default)

    $ gem 'foreman_ovm'

Then run `bundle install` from the same directory

-------------------

To verify that the installation was successful, go to Foreman, top bar **Administer > About** and check 'foreman_ovm' shows up in the **System Status** menu under the Plugins tab.

## Compatibility


| Foreman Version | Plugin Version |
| --------------- | --------------:|
| >= 1.13.0       | ~> 0.0.2       |

## Configuration

Go to **Infrastructure > Compute Resources** and click on "New Compute Resource".

Choose the **OVM provider**, and fill in all the fields. You need a service account with read and write access. It will be encrypted in the database.

That's it. You're now ready to create and manage droplets in your new OVM compute resource.

You should see something like this in the Compute Resource page:

![](http://i.imgur.com/a6yrxh4.png)
![](http://i.imgur.com/CTedBU1.png)

## How to contribute?

Generally, follow the [Foreman guidelines](http://theforeman.org/contribute.html). For code-related contributions, fork this project and send a pull request with all changes. Some things to keep in mind:
* [Follow the rules](http://theforeman.org/contribute.html#SubmitPatches) about commit message style and create a Redmine issue. Doing this right will help reviewers to get your contribution merged faster.
* [Rubocop](https://github.com/bbatsov/rubocop) will analyze your code, you can run it locally with `rake rubocop`.
* All of our pull requests run the full test suite in our [Jenkins CI system](http://ci.theforeman.org/). Please include tests in your pull requests for any additions or changes in functionality


### Latest code

You can get the nightly branch of the plugin by specifying your Gemfile in this way:

    gem 'foreman_ovm', :git => "https://github.com/mattwilmott/foreman-ovm.git"

# License

It is licensed as GPLv3 since it is a [Foreman](http://theforeman.org) plugin.

See LICENSE for more details.
