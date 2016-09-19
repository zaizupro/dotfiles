#!/bin/sh

VBoxManage showvminfo $1 --machinereadable | grep VMState= | cut -d '"' -f 2
