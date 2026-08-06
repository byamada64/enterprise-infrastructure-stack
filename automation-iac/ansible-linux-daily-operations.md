# 🛠️ Ansible Daily Linux Operations Check

## Build Summary

Created an Ansible daily operations check to evaluate repeatable Linux service validation, system health review, and operational consistency in a production-aligned scenario.

This build focuses on automation tradeoffs versus manual server checks, incorporating Ansible inventory, YAML playbooks, SSH-based execution, NGINX service validation, disk and memory checks, and failed service review within a governed lab environment.

## 🏗️ Environment Build Choices

- Platform: KodeKloud Ansible Sandbox Lab
- Ansible Version: 2.18.x
- Control Node: ansible-controller
- Managed Nodes: web1, web2
- Operating System: Ubuntu Linux
- Service Checked: NGINX
- Audit Scope: Uptime, Disk, Memory, Failed Services, Service Status
- Purpose: Perform repeatable daily operational checks across Linux servers using Ansible

## 📄 YAML File Used

### daily-ops.yml

~~~yaml
---
- name: Daily Linux Operations Check
  hosts: webservers
  become: yes

  tasks:
    - name: Check uptime
      command: uptime
      register: uptime_result
      changed_when: false

    - name: Check disk usage
      command: df -h
      register: disk_result
      changed_when: false

    - name: Check memory usage
      command: free -h
      register: memory_result
      changed_when: false

    - name: Check failed systemd services
      command: systemctl --failed --no-pager
      register: failed_services
      changed_when: false
      failed_when: false

    - name: Check nginx status
      command: systemctl is-active nginx
      register: nginx_status
      changed_when: false
      failed_when: false

    - name: Show daily ops summary
      debug:
        msg:
          - "Host: {{ inventory_hostname }}"
          - "Uptime: {{ uptime_result.stdout }}"
          - "NGINX Status: {{ nginx_status.stdout }}"
          - "Memory:"
          - "{{ memory_result.stdout_lines }}"
          - "Disk:"
          - "{{ disk_result.stdout_lines }}"
          - "Failed Services:"
          - "{{ failed_services.stdout_lines }}"
~~~

## 💻 Commands Used

- `mkdir -p ~/ansible-lab`
- `cd ~/ansible-lab`
- `vi daily-ops.yml`
- `ansible-playbook -i hosts daily-ops.yml`

## ✅ Validation

- Successfully connected to all managed hosts
- Collected uptime from:
  - web1
  - web2
- Verified disk utilization on both servers
- Verified memory usage on both servers
- Checked failed systemd services
- Confirmed NGINX service status as active
- Displayed structured daily operations summary per host
- Final play recap completed with:
  - `unreachable=0`
  - `failed=0`

## 🧠 Lessons Learned

- Ansible is effective for daily operational health checks
- Read-only commands can be automated safely across fleets
- Service validation reduces unnoticed outages
- Failed service reviews help identify hidden issues
- Repeated daily checks build operational consistency
- One playbook can standardize admin routines across servers
- Structured summaries improve triage speed

## 🔮 Future Improvements

- Add CPU load checks
- Add disk threshold alerting (80%+)
- Restart failed services automatically when approved
- Export results to HTML or CSV reports
- Send summaries to Slack or email
- Schedule via cron, Jenkins, or AWX
- Convert into reusable operations role

## 🧹 Final Hygiene Cleanup

- Remove temporary exported reports if created
- Sanitize inventory files before GitHub commits
- Do not commit plaintext credentials
- Clear terminal history if needed in shared labs
- End temporary KodeKloud sandbox when finished
