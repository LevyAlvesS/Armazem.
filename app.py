# importa a classe flask
from flask import Flask, render_template
# cria instância
app = Flask(__name__)
app.secret_key = "senha123"

# define rota para página inicial
@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
    