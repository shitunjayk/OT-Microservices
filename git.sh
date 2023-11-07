#!/bin/bash
set -x
while getopts ":u:d:" opt; do
    case $opt in
        u)
            repo_url="$OPTARG"
            ;;
        d)
            number_days="$OPTARG"
            ;;
    esac
done

git clone $repo_url
repo_name=$(basename "$repo_url" .git | sed 's/\.git$//')
cd $repo_name
#git log --pretty=format:"%ad|%an|%ae|%s" --since="$number_days days ago"


log_output=$(git log --pretty=format:"%ad|%an|%ae|%s" --since="$number_days days ago")

# HTML report file
report_file="git_commit_report.html"

# Write the HTML report
cat <<EOF > "$report_file"
<!DOCTYPE html>
<html>
<head>
  <title>Git Commit Report</title>
</head>
<body>
  <table border="1">
    <tr>
      <th>Date</th>
      <th>Author Name</th>
      <th>Author Email</th>
      <th>Commit Message</th>
    </tr>
    $log_output
  </table>
</body>
</html>
EOF

echo "Git commit report generated: $report_file"
