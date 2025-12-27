
export interface NewsItem {
  id: string;
  title: string;
  summary: string;
  content: string;
  author: string;
  date: string;
  category: 'News' | 'Culture' | 'Announcement';
  imageUrl: string;
}

export interface ForumPost {
  id: string;
  author: string;
  title: string;
  content: string;
  timestamp: string;
  likes: number;
  replies: number;
}

export interface VocabularyCard {
  word: string;
  translation: string;
  pronunciation: string;
  category: string;
}

export type View = 'home' | 'history' | 'language' | 'news' | 'community';
