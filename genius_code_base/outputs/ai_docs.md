# Codebase Documentation

## Overview
The `symfony/ai` repository hosts a Symfony component designed to provide an abstraction layer for interacting with various Artificial Intelligence (AI) providers. Its primary goal is to simplify the integration of AI capabilities like chat completions and embeddings into Symfony applications by offering a consistent API across different vendors such as OpenAI, Google, Anthropic, and Mistral. This approach allows developers to easily switch between AI providers without significant code changes, promoting flexibility and reducing vendor lock-in.

## Repository Structure
The repository follows a standard Symfony component structure:

*   **`src/`**: Contains the core source code of the AI component. This directory is further organized by concerns like `Client`, `Provider`, `Chat`, `Embedding`, and `DependencyInjection`.
*   **`tests/`**: Holds all the unit and integration tests for the component, ensuring its functionality and stability.
*   **`docs/`**: Provides documentation related to the component's usage and features.
*   **`config/`**: Contains configuration files, typically for service definitions or bundle configuration.
*   **`composer.json`**: Defines the project's metadata, dependencies, and scripts.
*   **`LICENSE`**: Specifies the licensing under which the software is distributed.
*   **`README.md`**: Provides a general introduction, installation instructions, and basic usage examples for the component.

## Key Files and Responsibilities

*   **`composer.json`**: This file is crucial for managing the component's dependencies. It lists external libraries required (e.g., `symfony/http-client`, specific AI SDKs like `openai-php/client`) and defines scripts for tasks like testing.
*   **`src/Client/`**: This directory likely contains the core interfaces and abstract classes for AI clients, defining common methods for interacting with AI models irrespective of the specific provider.
*   **`src/Provider/`**: This directory is responsible for holding the concrete implementations for different AI service providers (e.g., `OpenAI`, `Google`, `Anthropic`, `Mistral`). Each provider implementation translates the generic client interfaces into provider-specific API calls and data structures.
*   **`src/Chat/`**: Contains classes and interfaces specifically for handling chat-based AI interactions, including request/response models for chat messages and completions.
*   **`src/Embedding/`**: Houses the logic and data structures for generating and handling text embeddings, which are numerical representations of text.
*   **`src/DependencyInjection/`**: This directory contains the necessary classes (e.g., `AiExtension`) for integrating the component seamlessly into the Symfony Dependency Injection container, allowing services to be automatically configured and wired.
*   **`tests/` directory**: Provides comprehensive test coverage using PHPUnit, validating the functionality of different providers, chat interactions, and embedding generation.

## How to Run Locally

As `symfony/ai` is a component, it's not designed to be run as a standalone application. Instead, it is installed and used within another Symfony project.

To work with the component locally (e.g., for development or testing its internal logic):

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/symfony/ai.git
    cd ai
    ```

2.  **Install Dependencies:**
    Use Composer to install all required PHP dependencies:
    ```bash
    composer install
    ```

3.  **Run Tests:**
    To verify the component's functionality, execute its test suite:
    ```bash
    ./vendor/bin/phpunit
    ```
    or, if defined in `composer.json` scripts:
    ```bash
    composer test
    ```

To *use* this component in your own Symfony application, you would install it via Composer:
```bash
composer require symfony/ai
```
Then, configure it within your application's `config/packages/ai.yaml` (or similar) and inject the AI client services into your controllers or services. Specific usage examples would be found in the component's `README.md` or `docs/` directory.

## Possible Improvements

1.  **Expand AI Capabilities**: Beyond chat and embeddings, support for other AI features like image generation, speech-to-text, text-to-speech, or advanced agent tooling could be integrated.
2.  **More Providers**: While a good set is covered, adding support for more specialized or emerging AI providers (e.g., Azure OpenAI, Cohere, various open-source models via services like Hugging Face Inference API) would enhance its utility.
3.  **Advanced Configuration Options**: Implement more fine-grained control over provider-specific settings, such as custom API endpoints, proxy configurations, request timeouts, and advanced retry strategies.
4.  **Streaming Support**: Enhance the chat capabilities to support streaming responses from AI models, allowing for real-time display of generated text which improves user experience.
5.  **Caching Mechanisms**: Introduce an optional caching layer for AI responses (especially for embeddings or common chat prompts) to reduce API calls and improve performance.
6.  **Detailed Error Handling and Logging**: Provide more specific and actionable error messages, and integrate robust logging to help diagnose issues with AI API interactions.
7.  **Cookbook and Advanced Examples**: Expand the documentation with more practical examples ("cookbooks") for common use cases, demonstrating how to integrate the component with other Symfony features (e.g., Messenger, Workflow).