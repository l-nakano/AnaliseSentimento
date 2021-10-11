# AnaliseSentimento
Este é um app responsável pela busca de um usuário no Twitter e análise do sentimento dos últimos posts feito por ele.

# Descrição
App conta com duas telas, uma na qual o usuário realizará a busca de um username do Twitter e a outra que apresentará alguns dados do usuário selecionado e os últimos posts feito por ele, com as respectivas análises de sentimento de cada post.

# Solução Adotada
Para a criação do app AnaliseSentimento foram consideradas as seguintes soluções:

## Extração de Dados
Os dados utilizados neste app foram extraídos da API REST do Twitter (https://developer.twitter.com).
Para a execução desta tarefa, foi utilizado o Pod Alamofire, a fim de facilitar na extração, validação e decodificação dos dados para as estruturas adotadas no programa.

## Arquitetura
A arquitetura adotada foi a MVVM, segmentada em:
### Model
Composto pelos modelos de dados para decodificação dos dados extraídos da API e pelos dados para validação do username inserido pelo usuário.
### View
Composto pelas duas telas que foram representadas no app: entrada do usuário com o username do Twitter e apresentação dos posts e análises de sentimento.
### View Model
Composto pelas classes que realizam a comunicação entre o modelo e a respectiva View.

Ainda existem outros arquivos de suporte, utilizados para extração dos dados da API. Eles conectam o app com os serviços de posts e de usuários (Services), bem como contém informações sobre os caminhos da API (Endpoints).

## Análise de Sentimentos
Para realizar a análise de sentimento dos posts do usuário selecionado, foi utilizada o framework Natural Language da Apple, por meio da classe NLTagger. O esquema de "sentiment score" foi utilizado para analisar a nota de um determinado texto, o que irá retornar um valor entre -1 e 1 (sendo -1 muito negativo e 1 muito positivo).
