import { WebPlugin } from '@capacitor/core';

import type { FacebookLoginPlugin } from './definitions';

export class FacebookLoginWeb extends WebPlugin implements FacebookLoginPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
