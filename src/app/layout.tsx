import type { Metadata } from 'next'
import { Inter, Noto_Sans_Devanagari } from 'next/font/google'
import { siteConfig } from '@/config/site'
import './globals.css'

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
  display: 'swap',
})

const notoDevanagari = Noto_Sans_Devanagari({
  subsets: ['devanagari'],
  weight: ['400', '500', '600', '700'],
  variable: '--font-devanagari',
  display: 'swap',
})

export const metadata: Metadata = {
  title: {
    template: `%s | ${siteConfig.name}`,
    default: `${siteConfig.name} — Free Study Resources for NEB Grade 11 & 12`,
  },
  description:
    'Free notes, past papers and model questions for Nepal NEB Grade 11 and 12 Science and Management students.',
  keywords: ['NEB', 'Nepal', 'Grade 11', 'Grade 12', 'Science', 'Management', 'notes', 'past papers'],
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html
      lang="en"
      data-scroll-behavior="smooth"
      suppressHydrationWarning
      className={`${inter.variable} ${notoDevanagari.variable}`}
    >
      <body className="flex flex-col min-h-screen">
        {children}
      </body>
    </html>
  )
}
