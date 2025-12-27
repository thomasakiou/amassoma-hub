
import React from 'react';

export const ICONS = {
  Home: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
  ),
  History: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
  ),
  Language: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m5 8 6 6"/><path d="m4 14 6-6 2-3"/><path d="M2 5h12"/><path d="M7 2h1"/><path d="m22 22-5-10-5 10"/><path d="M14 18h6"/></svg>
  ),
  News: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M4 22h16a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2H8a2 2 0 0 0-2 2v16a2 2 0 0 1-2 2Zm0 0a2 2 0 0 1-2-2v-9c0-1.1.9-2 2-2h2"/><path d="M18 14h-8"/><path d="M15 18h-5"/><path d="M10 6h8v4h-8V6Z"/></svg>
  ),
  Community: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
  ),
  Send: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="22" y1="2" x2="11" y2="13"/><polyline points="22 2 15 22 11 13 2 9 22 2"/></svg>
  ),
  Video: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m22 8-6 4 6 4V8Z"/><rect width="14" height="12" x="2" y="6" rx="2" ry="2"/></svg>
  ),
  Play: () => (
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="currentColor" stroke="none"><polygon points="5 3 19 12 5 21 5 3"/></svg>
  )
};

export const MOCK_NEWS = [
  {
    id: '1',
    title: 'New Infrastructure Project at NDU',
    summary: 'The Niger Delta University (NDU) in Amassoma set to receive state-of-the-art research facility.',
    content: 'A new research hub is being commissioned by the Bayelsa State government to improve STEM education in Amassoma.',
    author: 'Kurobiari Ebi',
    date: 'Oct 24, 2023',
    category: 'News',
    imageUrl: 'https://picsum.photos/seed/ndu/600/400'
  },
  {
    id: '2',
    title: 'Amassoma Cultural Festival Dates Announced',
    summary: 'The annual festival celebrating the rich Izon heritage of the Southern Ijaw people will take place this December.',
    content: 'Prepare for a week of boat regattas, traditional wrestling, and masquerade displays.',
    author: 'Chief Tari',
    date: 'Nov 02, 2023',
    category: 'Culture',
    imageUrl: 'https://picsum.photos/seed/culture/600/400'
  }
];

export const VOCABULARY = [
  { word: 'Ado', translation: 'Hello', pronunciation: 'Ah-doh', category: 'Greetings' },
  { word: 'Nua', translation: 'Thank you', pronunciation: 'Noo-ah', category: 'Etiquette' },
  { word: 'Obiri', translation: 'Dog', pronunciation: 'Oh-bee-ree', category: 'Animals' },
  { word: 'Amanyanawei', translation: 'King/Ruler', pronunciation: 'Ah-man-yah-nah-way', category: 'Society' },
  { word: 'Beni', translation: 'Water', pronunciation: 'Beh-nee', category: 'Nature' },
];

export const VIDEO_CLASSES = [
  {
    id: 'v1',
    title: 'Introduction to Izon Grammar',
    instructor: 'Prof. Diepreye',
    duration: '45 mins',
    type: 'Recorded',
    thumbnail: 'https://picsum.photos/seed/class1/400/225'
  },
  {
    id: 'v2',
    title: 'Amassoma Traditional Chants',
    instructor: 'Elder Kuro',
    duration: '1h 20m',
    type: 'Recorded',
    thumbnail: 'https://picsum.photos/seed/class2/400/225'
  }
];
