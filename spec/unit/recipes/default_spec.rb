#
# Cookbook Name:: phd_motd
# Spec:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

require 'spec_helper'

describe 'motd_phd::default' do
  { 'ubuntu' => '16.04',
    'centos' => '7.2.1511'
  }.each do |platform, v|
    context "when converging with default attributes on #{platform.capitalize} #{v}" do

      let(:user) { 'root' }
      let(:group) { 'root' }
      let(:template) { '/etc/motd' }
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: platform, version: v) do |node|
          node.normal['motd_phd']['owner'] = user
          node.normal['motd_phd']['group'] = group
          node.normal['motd_phd']['company'] = 'Your Company'
        end.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'creates the motd template' do
        expect(chef_run).to create_template(template).with(
          owner: user,
          group: group,
          mode: '0644'
        )
        expect(chef_run).to render_file(template).with_content(
          'Your default company name is Your Company'
        )
      end
    end
  end
end
