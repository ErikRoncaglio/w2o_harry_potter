# 🧙‍♂️ Harry Potter App - Teste Técnico Flutter

Aplicativo desenvolvido como parte do processo seletivo para a vaga de Desenvolvedor Flutter Pleno. Este projeto demonstra a implementação de uma arquitetura robusta e escalável para consulta de dados do universo Harry Potter.

## ✨ Funcionalidades

- **📜 Listagem de Personagens:** Visualize todos os personagens da saga com informações detalhadas
- **💾 Cache Offline-First:** Navegue pelos dados mesmo sem conexão com a internet
- **🏰 Filtro por Casa:** Filtre personagens pelas casas de Hogwarts (Gryffindor, Slytherin, Ravenclaw, Hufflepuff)
- **👤 Detalhes do Personagem:** Visualize informações completas com transições animadas
- **✨ Listagem de Magias:** Consulte o catálogo completo de magias do universo bruxo
- **🏛️ Explorar Casas:** Página dedicada às casas de Hogwarts com navegação intuitiva
- **🌙 Tema Dinâmico:** Adaptação automática ao tema claro/escuro do sistema
- **🌍 Multi-idiomas:** Suporte para Português e Inglês
- **🎨 Animações Sutis:** Transições suaves e feedback visual aprimorado

## 🛠️ Tecnologias e Arquitetura

### Arquitetura
- **Clean Architecture** com separação estrita entre camadas
- **Offline-First Strategy** para máxima disponibilidade
- **SOLID Principles** aplicados em todo o codebase

### Stack Tecnológica
- **Estado:** Provider com ChangeNotifier
- **Persistência:** Hive para storage local rápido
- **HTTP:** Dio para requisições à API
- **Injeção de Dependência:** GetIt para desacoplamento
- **Testes:** Testes unitários com mocks customizados
- **Animações:** Flutter Animate para UX aprimorada
- **Internacionalização:** Flutter Intl

### APIs Utilizadas
- **Personagens:** `https://hp-api.onrender.com/api/characters`
- **Magias:** `https://hp-api.onrender.com/api/spells`

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK (versão 3.0 ou superior)
- Dart SDK
- Android Studio/VS Code
- Dispositivo Android/iOS ou emulador

### Instalação
```bash
# Clone o repositório
git clone <URL_DO_REPOSITORIO>

# Entre na pasta do projeto
cd w2o_harry_potter

# Instale as dependências
flutter pub get

# Execute o gerador de código para Hive
flutter pub run build_runner build

# Execute o aplicativo
flutter run
```

### Executar Testes
```bash
# Testes unitários
flutter test

# Análise de código
flutter analyze

# Formatação automática
dart format .
```

## 📱 Capturas de Tela

*(As capturas de tela seriam adicionadas aqui em um projeto real)*

## 🏗️ Estrutura do Projeto

```
lib/
├── core/                    # Configurações globais
│   ├── injection/          # Injeção de dependências
│   ├── theme/             # Temas da aplicação
│   └── constants/         # Constantes globais
├── data/                   # Camada de dados
│   ├── datasources/       # Fontes de dados (API, Local)
│   ├── models/           # Modelos de dados
│   └── repositories/     # Implementação dos repositórios
├── domain/                # Camada de negócio
│   ├── entities/         # Entidades de domínio
│   ├── repositories/     # Contratos dos repositórios
│   └── usecases/        # Casos de uso
├── presentation/          # Camada de apresentação
│   ├── pages/           # Telas da aplicação
│   ├── providers/       # Gerenciamento de estado
│   └── widgets/        # Componentes reutilizáveis
└── l10n/                 # Internacionalização
```

## 🧪 Estratégia de Testes

### Testes Implementados
- **Testes Unitários:** Provider de personagens com cenários de sucesso e erro
- **Mocks:** Repositórios mockados para isolamento de testes
- **Cobertura:** Focada na lógica de negócio crítica

### Cenários Testados
- ✅ Carregamento bem-sucedido de personagens
- ✅ Tratamento de erros de rede
- ✅ Estados de loading corretos
- ✅ Transições de estado do Provider

## 🎯 Decisões de Arquitetura

### Clean Architecture
A escolha pela Clean Architecture foi motivada pela necessidade de:
- **Testabilidade:** Camadas isoladas facilitam testes unitários
- **Manutenibilidade:** Separação clara de responsabilidades
- **Escalabilidade:** Fácil adição de novas funcionalidades
- **Independência:** Desacoplamento entre UI, negócio e dados

### Offline-First com Hive
- **Performance:** Acesso instantâneo aos dados cacheados
- **Experiência:** Funcionalidade mesmo sem internet
- **Eficiência:** Redução de chamadas desnecessárias à API
- **Confiabilidade:** Dados sempre disponíveis

### Provider para Estado
- **Simplicidade:** API intuitiva e bem documentada
- **Performance:** Reconstrução eficiente de widgets
- **Debugging:** Ferramentas excelentes para desenvolvimento
- **Comunidade:** Amplamente adotado pela comunidade Flutter

## 📈 Melhorias Futuras

### Funcionalidades
- [ ] Busca avançada com filtros múltiplos
- [ ] Favoritos offline
- [ ] Detalhes expandidos de magias
- [ ] Quiz interativo sobre Harry Potter
- [ ] Compartilhamento de personagens

### Técnicas
- [ ] Testes de integração e widget
- [ ] CI/CD pipeline
- [ ] Análise de performance
- [ ] Monitoramento de crashes
- [ ] Otimização de imagens

## 👨‍💻 Autor

Desenvolvido como demonstração de habilidades em Flutter, seguindo as melhores práticas da indústria e focado na experiência do usuário.

---

## 📄 Licença

Este projeto foi desenvolvido para fins de avaliação técnica.

---

*"It is our choices, Harry, that show what we truly are, far more than our abilities."* - Albus Dumbledore
