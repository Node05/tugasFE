import React from 'react';
import Navbar from './components/Navbar';
import Hero from './components/Hero';
import KategoriUnggulan from './components/KategoriUnggulan';
import TokoUnggulan from './components/TokoUnggulan';
import KomitmenPelayanan from './components/KomitmenPelayanan';
import Footer from './components/Footer';

export default function App() {
  return (
    <div className="min-h-screen bg-slate-50">
      <Navbar />
      <main>
        <Hero />
        <KategoriUnggulan />
        <TokoUnggulan />
        <KomitmenPelayanan />
      </main>
      <Footer />
    </div>
  );
}