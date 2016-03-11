FactoryGirl.define do
  factory :event, aliases: [:analyze_task_requested_event], class: Hash do
    skip_create
    initialize_with do
      {
        'data' => {
          'id' => 'e549e587-48cd-4f6c-85c7-b7ebfa14ac59',
          'type' => 'analyze_tasks',
          'attributes' => {
            'status' => 'scheduled', 'language' => 'All', 'tool' => 'Linguist', 'type' => 'AnalyzeTask'
          },
          'relationships' => {
            'build' => {'data' => {'id' => '08d832dd-e04c-4c9e-83f5-04d2b7c8138a', 'type' => 'builds'}}
          }
        },
        'included' => [
          {
            'id' => '08d832dd-e04c-4c9e-83f5-04d2b7c8138a',
            'type' => 'builds',
            'attributes' => {
              'ssh_public_key' => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCofqDGRd4ZdlUUppC6943LJGwK1ccj1lr0b+ovoaPjtb2BBydBIGpK5jSF6vXCo38mOKJNFdmJsLM9FwW5uqF3dDj5co4LbrLJ4JjC6MlKWfX3hlffOL4QcPYGb1O/4RyJPyFyuHAclvy2E1KIhJbShjtwt5QtIUkNy0QbVgTw6jARL0cOKXmVQJjMbXtSxXCvEd6e3HM+GJn2uhLCZLH4EYaw8BysB9yseM5p9NJmkK6x0kkylTBWQWBWlAg5ZUGButrTZ42cT6aP9OopR0qFJgYFXu75oueo/11L3yyutggCi5j4rpqPCgXqE5npl/vOTA5q/2oPw5dxZt4cwXP LintCI',
              'ssh_private_key' => "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAwqH6gxkXeGXZVFKaQuveNyyRsCtXHI9Za9G/qL6Gj47W9gQc\nnQSBqSuY0her1wqN/JjiiTRXZibCzPRcFubqhd3Q4+XKOC26yyeCYwujJSln194Z\nX3zi+EHD2Bm9Tv+EciT8hcrhwHJb8thNSiISW0oY7cLeULSFJDctEG1YE8OowES9\nHDil5lUCYzG17UsVwrxHentxzPhiZ9roSwmSx+BGGsPAcrAfcrHjOafTSZpCusdJ\nJMpUwVkFgVpQIOWVBgbra02eNnE+mj/TqKUdKhSYGBV7u+aLnqP9dS98srrYIAou\nY+K6ajwoF6hOZ6Zf7zkwOav9qD8OXcWbeHMFzwIDAQABAoIBADYtprFFk8308/lQ\nARbt126eXnOerOILWUX1HhfX6Vce2OGkpV5j+b/gneqlojT7ACk3WZ/9zPJnicRJ\npTTO1Kus4k/+EDtxJ1UTy2zMuX5Ht1tUvNViyz919xE5oQPThsfLWevYXN0YOFYy\nNdmUAG4fAy90FjR6+7DoFwhCl8jwKq83G8OzbOrahCEmLMlCnKEV8deZyMCKQQdJ\nh11K6Xm3cXOGWr5doHQaQzs/jMgLFq2BT/9HI9u68UpVHhf+/7maEteWWkqWI/XH\nE9hO+Okx/XK/QCc37fp5rYyK9DLp5qvKABc9TymZuyBavev/OZVd3rEU70nt4GRw\nocE5ggkCgYEA6QX0u9sVAvZsKStBcQEoPVmV7QDgQxgZ0HQ+Nt/VxPVJ8p/NxxRw\nAB2egeQaSo63u6Gr4p6ff7WilgZG1pmCSW6H+pS8bic7Hfn6AjemaQDPhXesSDj1\nZPOG0QPy7GwtkLZKedT6JinDqpLEBCwu617NHMl8lIq+2IpVVd4IKBsCgYEA1dL0\n/RNKnGFCoWabeFUYgTcdamFrPdRNgVt1+0MCM40rDqLNeML8kjVdmEsdlIX0flyB\nsUEfxcB4v0DVlYz8U5/HLOAJWiUDJxioz4cLAeaEa/aFMrDl76PkU5OftXNF3zla\nuiPRmhALh5RUZNsr79HdXJsWsZUZkesq603knF0CgYBg0aaz/v0l8/lQybYxG8f6\nZaSTis+jUPo40HOhHTOW2EvXUWqQkv9OLQBU+8+ots/EWBIw4LNovrFFIGqCc9nc\nZN5+0RnRst8vP1QPY8vyyPFwhR7CC1h6j2yun7NpZDEydWtQX5toC+ZOkxh6m1kL\nVqJmmZj3pwZQtnlqagx9jQKBgQC1ikhKXgiowMLrecxh3A3UF1E4MsH0Wr37KAYB\ncCD8V8zIvlypPRNnpztxw8S3hwvQBQZv0hUBtqpN5uPv9yV8clmOth/6kxYcKYmZ\nuNQVpvujFkh8g0iVr5Z5hwq/6cDXB0EKbMLWhOzlDYChqJujH5FLwLkByM9O3lUw\nNo/0WQKBgQCVjmOqDZ5orh1GvWI/JiR06pxKaPHx3NSlaMSbuqjekOkG2CCCt+6E\nIrijflTdimvis14jFordpLFrbywbG3Pagi4egp5YpPalOcwdcW4OJPA/5dsQkeHy\nz1ec5+ja4Wfm4iZmdGCvjeb4dguIkWh0q7obKugs4n1xjUpJuiXzWg==\n-----END RSA PRIVATE KEY-----\n"
            },
            'relationships' => {'pull_request' => {'data' => {'id' => '1', 'type' => 'pull_requests'}}}
          },
          {
            'id' => '1',
            'type' => 'pull_requests',
            'attributes' => {
              'base_sha' => 'bbf813a806dacf043a592f04a0ed320236caca3a',
              'head_sha' => '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
              'branch' => 'mostly-bad',
              'clone_url' => 'git://github.com/lintci/guinea_pig.git',
              'owner' => 'lintci',
              'repo' => 'guinea_pig'
            }
          }
        ],
        'meta' => {
          'event' => 'pull_request',
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
          'requested_at' => '2016-03-05T21:41:50Z'
        }
      }
    end

    factory :lint_task_requested_event do
      skip_create
      initialize_with do
        {
          'data' => {
            'id' => '76dca915-48e0-42fe-b8df-e57298039479',
            'type' => 'lint_tasks',
            'attributes' => {
              'status' => 'scheduled',
              'language' => 'Ruby',
              'tool' => 'RuboCop',
              'type' => 'LintTask'
            },
            'relationships' => {
              'build' => {
                'data' => {
                  'id' => '1848cc64-fd0f-400d-a382-0b0288a75ed0',
                  'type' => 'builds'
                }
              },
              'source_files' => {
                'data' => [
                  {
                    'id' => 'ce282708-3918-4405-bd6d-81aaaa15428d',
                    'type' => 'source_files'
                  }
                ]
              }
            }
          },
          'included' => [
            {
              'id' => '1848cc64-fd0f-400d-a382-0b0288a75ed0',
              'type' => 'builds',
              'attributes' => {
                'ssh_public_key' => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCofqDGRd4ZdlUUppC6943LJGwK1ccj1lr0b+ovoaPjtb2BBydBIGpK5jSF6vXCo38mOKJNFdmJsLM9FwW5uqF3dDj5co4LbrLJ4JjC6MlKWfX3hlffOL4QcPYGb1O/4RyJPyFyuHAclvy2E1KIhJbShjtwt5QtIUkNy0QbVgTw6jARL0cOKXmVQJjMbXtSxXCvEd6e3HM+GJn2uhLCZLH4EYaw8BysB9yseM5p9NJmkK6x0kkylTBWQWBWlAg5ZUGButrTZ42cT6aP9OopR0qFJgYFXu75oueo/11L3yyutggCi5j4rpqPCgXqE5npl/vOTA5q/2oPw5dxZt4cwXP LintCI',
                'ssh_private_key' => "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAwqH6gxkXeGXZVFKaQuveNyyRsCtXHI9Za9G/qL6Gj47W9gQc\nnQSBqSuY0her1wqN/JjiiTRXZibCzPRcFubqhd3Q4+XKOC26yyeCYwujJSln194Z\nX3zi+EHD2Bm9Tv+EciT8hcrhwHJb8thNSiISW0oY7cLeULSFJDctEG1YE8OowES9\nHDil5lUCYzG17UsVwrxHentxzPhiZ9roSwmSx+BGGsPAcrAfcrHjOafTSZpCusdJ\nJMpUwVkFgVpQIOWVBgbra02eNnE+mj/TqKUdKhSYGBV7u+aLnqP9dS98srrYIAou\nY+K6ajwoF6hOZ6Zf7zkwOav9qD8OXcWbeHMFzwIDAQABAoIBADYtprFFk8308/lQ\nARbt126eXnOerOILWUX1HhfX6Vce2OGkpV5j+b/gneqlojT7ACk3WZ/9zPJnicRJ\npTTO1Kus4k/+EDtxJ1UTy2zMuX5Ht1tUvNViyz919xE5oQPThsfLWevYXN0YOFYy\nNdmUAG4fAy90FjR6+7DoFwhCl8jwKq83G8OzbOrahCEmLMlCnKEV8deZyMCKQQdJ\nh11K6Xm3cXOGWr5doHQaQzs/jMgLFq2BT/9HI9u68UpVHhf+/7maEteWWkqWI/XH\nE9hO+Okx/XK/QCc37fp5rYyK9DLp5qvKABc9TymZuyBavev/OZVd3rEU70nt4GRw\nocE5ggkCgYEA6QX0u9sVAvZsKStBcQEoPVmV7QDgQxgZ0HQ+Nt/VxPVJ8p/NxxRw\nAB2egeQaSo63u6Gr4p6ff7WilgZG1pmCSW6H+pS8bic7Hfn6AjemaQDPhXesSDj1\nZPOG0QPy7GwtkLZKedT6JinDqpLEBCwu617NHMl8lIq+2IpVVd4IKBsCgYEA1dL0\n/RNKnGFCoWabeFUYgTcdamFrPdRNgVt1+0MCM40rDqLNeML8kjVdmEsdlIX0flyB\nsUEfxcB4v0DVlYz8U5/HLOAJWiUDJxioz4cLAeaEa/aFMrDl76PkU5OftXNF3zla\nuiPRmhALh5RUZNsr79HdXJsWsZUZkesq603knF0CgYBg0aaz/v0l8/lQybYxG8f6\nZaSTis+jUPo40HOhHTOW2EvXUWqQkv9OLQBU+8+ots/EWBIw4LNovrFFIGqCc9nc\nZN5+0RnRst8vP1QPY8vyyPFwhR7CC1h6j2yun7NpZDEydWtQX5toC+ZOkxh6m1kL\nVqJmmZj3pwZQtnlqagx9jQKBgQC1ikhKXgiowMLrecxh3A3UF1E4MsH0Wr37KAYB\ncCD8V8zIvlypPRNnpztxw8S3hwvQBQZv0hUBtqpN5uPv9yV8clmOth/6kxYcKYmZ\nuNQVpvujFkh8g0iVr5Z5hwq/6cDXB0EKbMLWhOzlDYChqJujH5FLwLkByM9O3lUw\nNo/0WQKBgQCVjmOqDZ5orh1GvWI/JiR06pxKaPHx3NSlaMSbuqjekOkG2CCCt+6E\nIrijflTdimvis14jFordpLFrbywbG3Pagi4egp5YpPalOcwdcW4OJPA/5dsQkeHy\nz1ec5+ja4Wfm4iZmdGCvjeb4dguIkWh0q7obKugs4n1xjUpJuiXzWg==\n-----END RSA PRIVATE KEY-----\n"
              },
              'relationships' => {
                'pull_request' => {
                  'data' => {
                    'id' => '1',
                    'type' => 'pull_requests'
                  }
                }
              }
            },
            {
              'id' => '1',
              'type' => 'pull_requests',
              'attributes' => {
                'base_sha' => 'bbf813a806dacf043a592f04a0ed320236caca3a',
                'head_sha' => '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
                'branch' => 'mostly-bad',
                'clone_url' => 'git://github.com/lintci/guinea_pig.git',
                'owner' => 'lintci',
                'repo' => 'guinea_pig'
              }
            },
            {
              'id' => 'ce282708-3918-4405-bd6d-81aaaa15428d',
              'type' => 'source_files',
              'attributes' => {
                'name' => 'bad.rb',
                'sha' => 'cbc7b6a779837b93563e69511d44cb35051ed712',
                'source_type' => 'Ruby',
                'language' => 'Ruby',
                'linters' => ['RuboCop'],
                'modified_lines' => [1, 2, 3, 4],
                'extension' => '.rb',
                'size' => 31,
                'generated' => false,
                'vendored' => false,
                'documentation' => false,
                'binary' => false,
                'image' => false
              }
            }
          ],
          'meta' => {
            'event' => 'pull_request',
            'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
            'requested_at' => '2016-03-01T02:34:53Z'
          }
        }
      end
    end
  end
end
