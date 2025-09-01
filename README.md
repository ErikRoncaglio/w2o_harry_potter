# Projeto Flutter Harry Potter - Teste W2O

Aplicativo sobre o universo de Harry Potter, desenvolvido como parte do processo seletivo para a vaga de Desenvolvedor Flutter Pleno na W2O Softwares.

O projeto foi construído com foco em boas práticas, arquitetura limpa e uma experiência de usuário rica, implementando todos os requisitos obrigatórios e não-obrigatórios solicitados.

## ✨ Funcionalidades

O aplicativo oferece uma experiência completa e resiliente, com as seguintes funcionalidades:

* **🧙‍♂️ Listagem de Personagens:** Visualize todos os personagens da saga com busca e scroll infinito.
* ** offline Cache Offline-First:** Navegue pelos dados já carregados mesmo sem conexão com a internet.
* ** Tela de Detalhes:** Toque em um personagem para ver informações detalhadas, com uma transição de tela animada.
* ** Filtro por Casa:** Filtre a lista de personagens pela sua casa de Hogwarts (Grifinória, Sonserina, etc.).
* ** Listagem de Magias:** Consulte uma lista com as magias do universo bruxo.
* ** Listagem de Casas:** Explore as casas de Hogwarts e veja seus membros.
* ** Tema Dinâmico (Claro/Escuro):** O aplicativo se adapta automaticamente ao tema do sistema operacional.
* ** Ícone:** Identidade visual customizada com o Chapéu Seletor desde a inicialização.
* ** Multi-idioma (i18n):** Suporte completo para Português e Inglês.
* ** Tela de Configurações:** Permite que o usuário troque manualmente o tema e o idioma do aplicativo, com as escolhas salvas entre as sessões.

## 🛠️ Arquitetura e Tecnologias Utilizadas

O projeto foi estruturado para ser escalável, testável e de fácil manutenção, utilizando um conjunto de ferramentas modernas do ecossistema Flutter.

| Categoria                 | Tecnologia/Padrão                                                             |
| ------------------------- | ----------------------------------------------------------------------------- |
| **Arquitetura** | **Clean Architecture** (camadas de Data, Domain e Presentation)               |
| **Gerenciamento de Estado** | **Provider** (com `ChangeNotifier` para reatividade da UI)                    |
| **Banco de Dados Local** | **Hive** (para persistência de dados e cache offline)                         |
| **Injeção de Dependência** | **GetIt** (para gerenciar as dependências de forma centralizada)              |
| **Requisições HTTP** | **Dio** (para comunicação com a HP-API)                                       |
| **Testes** | **Mockito** (para criação de Mocks nos testes unitários do Provider)          |
| **Branding** | `flutter_launcher_icons` (ícone) |
| **Internacionalização** | `flutter_localizations` (gerenciamento de múltiplos idiomas)                  |
| **Persistência de Pref.** | `shared_preferences` (para salvar as configurações do usuário)                |

## 📁 Estrutura de Pastas

A estrutura do projeto segue os princípios da Clean Architecture, separando as responsabilidades de forma clara:

```
lib/
├── core/                 # Arquivos base: Tema, Injeção de Dependência, etc.
├── data/                 # Fontes de dados (API, Local DB) e Repositórios (Implementação)
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/               # Lógica de negócio pura: Entidades, UseCases e Repositórios (Contratos)
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/         # Camada de UI: Telas, Widgets e Providers
    ├── pages/
    ├── providers/
    └── widgets/
```

## 🚀 Como Executar o Projeto

Para executar este projeto localmente, siga os passos abaixo:

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    ```

2.  **Entre na pasta do projeto:**
    ```bash
    cd nome_do_projeto
    ```

3.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

4.  **Execute o gerador de código (para Hive e Mockito):**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

## 📝 Decisões Arquiteturais

A escolha pela **Clean Architecture** foi motivada pela necessidade de criar um código robusto, com baixo acoplamento 
entre as camadas, o que facilita a testabilidade e a manutenção a longo prazo. A implementação de uma **estratégia 
offline-first com o Hive** foi uma decisão chave para atender a um requisito de mercado cada vez mais 
presente: aplicativos que funcionam de forma resiliente, independentemente da qualidade da conexão do usuário. Por fim,
a adição de **testes unitários** no Provider demonstra um compromisso com a qualidade e a confiabilidade do código entregue.