# GoranJonsson2024-1

Run GPU-enabled containers for Jupyter Lab and QuPath using Podman

## Prerequisites

- Microsoft Windows with [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install)
- Nvidia Graphics Driver
- [Podman CLI](https://podman.io)
- [VcXsrv](https://sourceforge.net/projects/vcxsrv/)

### Creating a GPU-enabled Podman machine

Using the Command Prompt/PowerShell:

1. Create a new Podman machine:  
    `podman machine init`

2. Start the Podman machine:  
    `podman machine start`

3. Connect to the Podman machine:  
    `podman machine ssh`

4. Within the Podman machine, install the [Nvidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html):  
    `curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo`  
    `sudo yum install -y nvidia-container-toolkit`

5. Within the Podman machine, generate a [CDI](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html) specification and check the names of the generated devices:  
    `sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml`  
    `nvidia-ctk cdi list`
6. Note down the GPU device name (e.g., "nvidia.com/gpu=all") and exit the Podman machine:  
    `exit`

## Usage

### Jupyter Lab

1. Start the Podman machine (Command Prompt/PowerShell):  
    `podman machine start`

2. Run the Jupyter Lab container (Command Prompt/PowerShell):  
    `podman run --device nvidia.com/gpu=all -v C:\Users\USERNAME:/data -p 8888:8888 --rm ghcr.io/biifsweden/goranjonsson2024-1-jupyter`
    - Replace `nvidia.com/gpu=all` with your GPU device name
    - Replace `C:\Users\USERNAME` with the path to your home directory

3. Open Jupyter Lab by clicking on the link containing "127.0.0.1"

4. To stop the Jupyter Lab container, in Jupyter Lab, click File -> Shut down

### QuPath

1. Download and double-click the [config.xlaunch](config.xlaunch) file to start VcXsrv
    - Allow all Windows Defender Firewall requests that may appear (tick all checkboxes)
    - If no Windows Defender Firewall requests appear, open the Windows Defender Firewall -> click on "Allow an app or feature through Windows Defender Firewall" -> click on "Change settings" -> tick all checkboxes next to BOTH entries of "VcXsrv windows xserver" -> click "OK"

2. Start the Podman machine (Command Prompt/PowerShell):  
    `podman machine start`

3. Run the QuPath container (Command Prompt/PowerShell):  
    `podman run --device nvidia.com/gpu=all -v C:\Users\USERNAME:/data -e DISPLAY=$(hostname).local:0 --rm ghcr.io/biifsweden/goranjonsson2024-1-qupath`
    - Replace `nvidia.com/gpu=all` with your GPU device name
    - Replace `C:\Users\USERNAME` with the path to your home directory

4. To stop the QuPath container, simply close QuPath; exit VcXsrv via the System Tray

## License

[MIT](LICENSE)

## Contact

[SciLifeLab BioImage Informatics Facility (BIIF)](https://www.scilifelab.se/units/bioimage-informatics/)

Developed by [Jonas Windhager](mailto:jonas.windhager@scilifelab.se)
