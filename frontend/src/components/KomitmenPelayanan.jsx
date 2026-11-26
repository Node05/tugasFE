import React from 'react';

// Kalau file SVG sudah ada di folder src/assets/icons/, hapus tanda komentar (//) di bawah ini:
import iconPengiriman from '../assets/icons/Pengiriman.svg';
import iconPengembalian from '../assets/icons/Pengembalian.svg';
import iconHarga from '../assets/icons/harga.svg';
// import iconEscrow from '../assets/icons/escrow.svg';

const features = [
  {
    id: 'pengiriman',
    title: 'Pengiriman Terintegrasi',
    description:
      'Pengiriman rantai dingin (cold chain) untuk hasil tani segar dan gratis ongkir untuk pembelian di atas Rp. 1.000.000.',
    icon: iconPengiriman,
    size: 'w-14 h-14', // dibesarkan sedikit biar seimbang
  },
  {
    id: 'pengembalian',
    title: 'Jaminan Pengembalian',
    description:
      'Penggantian 100% bila barang atau jasa yang diterima tidak sesuai dengan standar.',
    icon: iconPengembalian,
    size: 'w-11 h-11',
  },
  {
    id: 'harga',
    title: 'Jaminan Harga',
    description:
      'Bebas dari perantara berlapis. Harga langsung diturunkan kepada produsen dan pembeli.',
    icon: iconHarga,
    size: 'w-11 h-11',
  },
  {
    id: 'escrow',
    title: 'Transaksi ESCROW',
    description:
      'Dana pembayaran hanya diteruskan ke petani setelah pesanan tiba di tangan Anda dengan selamat dan terverifikasi.',
    icon: iconPengiriman,
    size: 'w-14 h-14',
  },
];

export default function KomitmenPelayanan() {
  return (
    <section className="w-full bg-[#F4F6F9] py-14 md:py-16">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        {/* Header Tengah */}
        <div className="text-center max-w-3xl mx-auto">
          <p className="text-xs font-bold tracking-wider text-slate-800 uppercase">
            KOMITMEN PELAYANAN
          </p>

          <h2 className="mt-3 text-3xl sm:text-4xl md:text-[42px] font-bold tracking-tight leading-tight">
            <span className="text-[#0B6E5B]">Mengapa memilih Desa</span>
            <span className="text-[#00CFA6]">Kita</span>
            <span className="text-[#7DE2CE]"> ?</span>
          </h2>

          <p className="mt-4 text-xs sm:text-sm text-[#2D4563] leading-relaxed">
            Kami merancang platform ini dengan transparansi penuh untuk memudahkan para pembeli sekaligus mensejahterakan pelaku UMKM.
          </p>
        </div>

        {/* Garis Pemisah */}
        <hr className="my-9 border-slate-300" />

        {/* Grid 4 Keunggulan */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          {features.map((item) => (
            <div key={item.id} className="flex items-start gap-3.5">
              
              {/* Slot Tempat SVG */}
              <div className="shrink-0 mt-0.5 w-11 h-11 flex items-center justify-center">
                {item.icon ? (
                  <img
                    src={item.icon}
                    alt={item.title}
                    className="w-full h-full object-contain"
                  />
                ) : (
                  <div className="w-full h-full rounded-lg border-2 border-dashed border-slate-300 bg-slate-200/60" />
                )}
              </div>

              {/* Judul & Deskripsi */}
              <div>
                <h3 className="text-sm sm:text-base font-bold text-[#0F9D8A] leading-snug">
                  {item.title}
                </h3>
                <p className="mt-1.5 text-xs text-[#334E68] leading-relaxed">
                  {item.description}
                </p>
              </div>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
}