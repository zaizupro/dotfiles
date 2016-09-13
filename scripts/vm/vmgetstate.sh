#!/bin/sh

VBoxManage showvminfo $1 |grep State
