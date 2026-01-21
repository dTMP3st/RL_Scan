# RL_Scan

RL_Scan é uma ferramenta voltada para a área de segurança ofensiva, onde seu objetivo é validar se determinada aplicação ou API possui um controle de Rate Limit implementado. Essa validação é realizada de forma ativa, ou seja, haverá interação direta do host de origem com o alvo. O veredito final será baseado na quantidade requisições enviadas para o alvo e seus repectivos códigos de status retornados na resposta.

## Dependências
A execução do script RL_Scan.sh é dependente do pacote bc, que é responsável por realizar os cálculos do sucesso e falhas e temporização dos status de tempo retornado pelo script. A dependência pode ser instalada através do comando abaixo no Terminal.
```bash
sudo apt install bc
```