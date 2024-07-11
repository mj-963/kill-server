# kill-server

`kill-server` is a bash script to manage and terminate processes running on a specified port on macOS and Linux systems.

## Features

- Kill a single process running on a specified port.
- Forcefully kill a process without confirmation using the `-f` option.
- Kill all processes running on a specified port with the `-a` option, prompting for confirmation.
- Colorful and user-friendly command-line interface.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/kill-server.git
   cd kill-server
2. Make the script executable:
    ```bash
    chmod +x kill-server.sh
3. Optionally, move the script to a directory in your PATH to use it globally:
    ```bash
    sudo mv kill-server.sh /usr/local/bin/kill-server

## Usage

###### Basic Usage
- To kill a process running on a specific port:
    ```bash
    ./kill-server.sh <port>
###### Options
- `-f`: Forcefully kill the process without asking for confirmation.
- `-a`: Kill all processes running on the specified port with single confirmation.

###### Example

- ```bash
  # Forcefully kill a process on port 8080
  ./kill-server.sh -f 8080

  # Kill all processes on port 8080 with confirmation
  ./kill-server.sh -a 8080

  # Kill all processes on port 8080 forcefully
  ./kill-server.sh -a -f 8080

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/mj-963/kill-server/blob/main/LICENSE) file for details.

## Contributing
Contributions are welcome! Please feel free to submit pull requests.

## Acknowledgments

- Inspired by the need to manage processes faster and efficiently on macOS and Linux.
- Built with bash scripting and standard UNIX tools.

## Support

For support or questions, please open an issue in the GitHub repository.


### Notes:

- Replace `<port>` with the actual port number of server you want to kill.