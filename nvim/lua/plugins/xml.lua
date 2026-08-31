return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lemminx = {
          settings = {
            xml = {
              schemas = {
                {
                  fileMatch = { "pom.xml" },
                  url = "https://maven.apache.org/xsd/maven-4.0.0.xsd",
                },
              },
            },
          },
        },
      },
    },
  },
}
