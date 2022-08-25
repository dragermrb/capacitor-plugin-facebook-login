export interface FacebookLoginPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
