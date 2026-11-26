import React from 'react';

export default function Footer() {
  return (
    <footer className="w-full bg-[#003D99] text-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-14 pb-8">
        
        {/* Grid 4 Kolom */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-10">
          
          {/* Kolom 1: Brand & Deskripsi */}
          <div className="lg:col-span-4">
            <h3 className="text-lg font-bold tracking-tight">
              DesaKita – Marketplace Digital Desa
            </h3>
            <p className="mt-4 text-sm text-blue-100/90 leading-relaxed">
              DesaKita adalah marketplace digital yang memberdayakan para UMKM,
              petani, nelayan, dan pengrajin lokal untuk memasarkan produk mereka
              ke jangkauan yang lebih luas. Dengan DesaKita, Anda bisa menemukan
              berbagai produk unggulan dan komoditas lokal langsung dari tangan pertama.
            </p>
          </div>

          {/* Kolom 2: Jelajahi */}
          <div className="lg:col-span-2 lg:col-start-6">
            <h4 className="text-sm font-bold uppercase tracking-wider text-white">
              Jelajahi
            </h4>
            <ul className="mt-4 space-y-2.5 text-sm text-blue-100/85">
              <li>
                <a href="#beranda" className="hover:text-white transition">
                  Beranda
                </a>
              </li>
              <li>
                <a href="#kategori" className="hover:text-white transition">
                  Kategori Unggulan
                </a>
              </li>
              <li>
                <a href="#toko" className="hover:text-white transition">
                  Toko Lokal
                </a>
              </li>
              <li>
                <a href="#komitmen" className="hover:text-white transition">
                  Tentang DesaKita
                </a>
              </li>
            </ul>
          </div>

          {/* Kolom 3: Mitra & Layanan */}
          <div className="lg:col-span-3">
            <h4 className="text-sm font-bold uppercase tracking-wider text-white">
              Mitra & Layanan
            </h4>
            <ul className="mt-4 space-y-2.5 text-sm text-blue-100/85">
              <li>
                <a href="#daftar-mitra" className="hover:text-white transition">
                  Daftar Jadi Mitra UMKM
                </a>
              </li>
              <li>
                <a href="#cara-belanja" className="hover:text-white transition">
                  Cara Belanja
                </a>
              </li>
              <li>
                <a href="#escrow" className="hover:text-white transition">
                  Transaksi ESCROW
                </a>
              </li>
              <li>
                <a href="#pengembalian" className="hover:text-white transition">
                  Jaminan Pengembalian
                </a>
              </li>
            </ul>
          </div>

          {/* Kolom 4: Hubungi Kami */}
          <div className="lg:col-span-2">
            <h4 className="text-sm font-bold uppercase tracking-wider text-white">
              Hubungi Kami
            </h4>
            <ul className="mt-4 space-y-2.5 text-sm text-blue-100/85">
              <li>halo@desakita.id</li>
              <li>+62 812-3456-7890</li>
              <li>Senin – Sabtu, 08.00 – 17.00 WIB</li>
            </ul>
          </div>

        </div>

        {/* Garis Pemisah & Bottom Bar */}
        <div className="mt-12 pt-6 border-t border-white/20 flex flex-col sm:flex-row items-center justify-between gap-4 text-xs text-blue-100/80">
          <p>
            © {new Date().getFullYear()} DesaKita. Seluruh hak cipta dilindungi.
          </p>
          <div className="flex items-center gap-6">
            <a href="#syarat" className="hover:text-white transition">
              Syarat & Ketentuan
            </a>
            <a href="#privasi" className="hover:text-white transition">
              Kebijakan Privasi
            </a>
          </div>
        </div>

      </div>
    </footer>
  );
}