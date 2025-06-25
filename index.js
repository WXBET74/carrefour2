import express from "express";
import puppeteer from "puppeteer";

const app = express();
app.use(express.json());

app.post("/drive", async (req, res) => {
  console.log("🚀 Requête POST /drive reçue");
  const { email, password, produits } = req.body;

  if (!email || !password || !produits || !Array.isArray(produits)) {
    return res.status(400).send("Champs manquants : produits, email, password");
  }

  try {
    const browser = await puppeteer.launch({
      headless: true,
      args: ["--no-sandbox", "--disable-setuid-sandbox"]
    });

    const page = await browser.newPage();
    await page.goto("https://www.google.com"); // test simple

    await browser.close();
    res.send("Liste de courses envoyée !");
  } catch (err) {
    console.error(err);
    res.status(500).send("Erreur lors du traitement");
  }
});

app.listen(3000, () => {
  console.log("✅ Serveur Puppeteer en ligne sur le port 3000");
});