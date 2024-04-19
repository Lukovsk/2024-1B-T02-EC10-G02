// @ts-check
// `@type` JSDoc annotations allow editor autocompletion and type checking
// (when paired with `@ts-check`).
// There are various equivalent ways to declare your Docusaurus config.
// See: https://docusaurus.io/docs/api/docusaurus-config

import { themes as prismThemes } from "prism-react-renderer";

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "Ritalinos",
  tagline: "Dinosaurs are cool",
  favicon: "img/inteli.svg",

  // Set the production url of your site here
  url: "https://your-docusaurus-site.example.com",
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: "/2024-1B-T02-EC10-G02/",

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "Inteli-College", // Usually your GitHub org/user name.
  projectName: "2024-1B-T02-EC10-G02", // Usually your repo name.

  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: "./sidebars.js",
          routeBasePath: "/",
        },
        blog: false,
        theme: {
          customCss: "./src/css/custom.css",
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: "img/inteli.svg",
      navbar: {
        title: "Ritalinos",
        logo: {
          alt: "Logo Inteli",
          src: "img/inteli.svg",
        },
        items: [
          {
            type: "docSidebar",
            sidebarId: "tutorialSidebar",
            position: "left",
            label: "Tudo",
          },
          {
            type: "docSidebar",
            sidebarId: "sprint1Side",
            position: "left",
            label: "Sprint 1",
          },
          {
            type: "docSidebar",
            sidebarId: "sprint2Side",
            position: "left",
            label: "Sprint 2",
          },
          {
            type: "docSidebar",
            sidebarId: "sprint3Side",
            position: "left",
            label: "Sprint 3",
          },
          {
            type: "docSidebar",
            sidebarId: "sprint4Side",
            position: "left",
            label: "Sprint 4",
          },
          {
            type: "docSidebar",
            sidebarId: "sprint5Side",
            position: "left",
            label: "Sprint 5",
          },
          {
            href: "https://github.com/Inteli-College/2024-1B-T02-EC10-G02/",
            label: "GitHub",
            position: "right",
          },
        ],
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
      },
    }),
};

export default config;
