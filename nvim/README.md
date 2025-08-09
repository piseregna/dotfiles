Scrivo qualcosa per ricordarmi come funziona e come configurare LSP

Questa configurazione la posso usare solo se NVIM >= 0.11
Mason serve per installare i vari Language server
nvim-lspconfig invce serve per avviare il server
Mason-lspconfig funge da raccordo tra i due e permette nei file dei vari linguaggi di riferirsi a loro con il nome che usa Mason

Le configurazioni dei linguaggi vanno inseriti nella cartella lsp e devono avere il nome con il quale vengono abilitati nel file lsp-config
