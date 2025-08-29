mock_provider "google" {}

test {
  parallel = true
}

run "set_correct_vm_name" {
  variables {
    vm-name = "test-vm" #Change this variable to see the test fail.
  }

  assert {
    condition = google_compute_instance.test-vm.name == "test-vm"
    error_message   = "Incorrect vm name"
  }
}

run "vm_should_be_in_us" {
  variables {
    vm-name = "test-vm"
  }

  assert {
    condition     =  can(regex("us-*", google_compute_instance.test-vm.zone)) # Change the vm zone in main.tf to see the test fail.
    error_message = "VM is not in the US"
  }
}

