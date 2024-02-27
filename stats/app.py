from flask import Flask, render_template, request, redirect, url_for
import a2s
from rcon import rcon

SERVER_IP = 'cs16_server'
RCON_PORT = 27015
RCON_PASSWORD = 'password'
CS_SERVER_ADDRESS = (SERVER_IP, RCON_PORT)

app = Flask(__name__)


@app.route('/')
def home():
    try:
        server_info = a2s.info(CS_SERVER_ADDRESS)
        players = a2s.players(CS_SERVER_ADDRESS)
    except Exception as e:
        return f"Ошибка при получении данных с сервера: {e}"

    return render_template('index.html', server_info=server_info, players=players)

@app.route('/restart', methods=['POST'])
def restart_server():
    try:
        response = rcon(host=SERVER_IP, port=RCON_PORT, passwd=RCON_PASSWORD, command='restart')
        return "Сервер успешно перезапущен."
    except Exception as e:
        return f"Ошибка при рестарте сервера: {e}"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
