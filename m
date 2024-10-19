Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858171D54D3
	for <netfs@lists.linux.dev>; Sat, 19 Oct 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729322234; cv=none; b=mKdUKsD20rEuW+y/Tvx84AV1gtontZhTs6wuG+algtvAcA4gb80/ZhxBwvBZpg1yKQ4u3rFCIXQvrhyX+PGPp8kfC/qIfHl9/SF/B/A51nYRDC8Q7hrJH3aHJFF/uk6GZq5tP2P4TQlLFismrh0Xs5XM670ODamy+6TYcbgyAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729322234; c=relaxed/simple;
	bh=x77Leu//zcELEFm/jviPtto7y+OnBK4QnxtY2HQIYU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1ie3jCwz03wJwqSeNB5ZMYbkY9KrozhIl36cc3ye3W/kTYoBtV8/vNqyQIuNdqCFPh6EV009+m+AdLoBr1BkEr77zXWgqA2c3opCkynoLEPBZGy9sTX+fu7TvHlwAzr4r0uU+ifYR3iDSCo/6WOfDtPh3XqUcGLUAi9FnlGYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz10t1729322183tmx9pd
X-QQ-Originating-IP: 2wrtZZMSoIeiW4tN+ltGHjUUxkkLFPmvDWr8Q0tu8H4=
Received: from sonvhi-TianYi510S-07IMB.. ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 15:16:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15998112844559155357
From: chenxiaosong@chenxiaosong.com
To: corbet@lwn.net,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 3/3] tracing/Documentation: fix compile warning in debugging.rst
Date: Sat, 19 Oct 2024 15:15:39 +0800
Message-Id: <20241019071539.125934-4-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
References: <20241019071539.125934-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: ML8hOghqQD+0/XlLMPZYyEW0x1ZBxbHmjrEen821kLJ3+EqgbZQLh6Cy
	UkRLh36+wxHT7KAAgoyj7eJ8swsbAQYzMcdcqPAKg5uMJiOUPAxCS+Jdu9NW1N8Y7Cn2y5y
	M/kHE3rY/sraBmR5uYHJ/GvL4mJEgOOHB3euVodIhelLhReAy9iYv94GVt0IOjpmgLWVcVx
	w95IZuuX4muGZbdQOXhHr458oRZ6nbSjxHAOsqHLREkmoiSI6Sb5FqCn6RMIDV/gIRbvm02
	CroCN8cJXutCHZIFvNLXpaV+y/zFRdk1jKFVkuRKXDnNqq1XXajNxExcVsgbPnLC52j7D/D
	q8vh201husHxCpjjdY/nuFQrrGuF7jJLFhEt6G490NI2Mhe1SzeCrSDFz29ti7+V7H8keD9
	86MTTsjjm16rY0ZnIHP+qj6QOxQhOHMgadsQ+ICh/AUOA3oiwocHWY1JZHGHe0kM7Xs0yMo
	vZrAw+ERTmuwM4DwvZLNTBI1an50mQn+eRP3T0TCUQrJdIwsgRDF89jgJlObYHcRB3kW0FV
	OVssBpf1nx/tbhNPx8gsi1ZddwNJe/r1QOazlNTZ5D+gfm1frvBlCQ1APhSW8Xiw4R2ep0y
	RfiP0gtSUDtVwRf1T1o4QpLMKMnqyKQGgerzuK6bixjiyev9xucpWWZ5wMPLudypNJWm6q+
	slQY8ciSVublXTprzNgUJ+qUSr6uUMeZNoTL7VCUVPtbBYOnYi+ttpWcU7DL6lxqoRQfXcd
	GtW2bPrbDSNfCdODYNbWDgI+HZNrwUZaeUzeH5b0nH3RI3rXpg5cAhhU9FZwxIURRXFFrV+
	ggV3+YpWJ+4SQxJKa5sso81BakSjpQzb84vjEKxZZCFInb1slSrfaCxDJ6Pwkv8pfHyTHZc
	x5xLKYDdeOFyq6O3AJ2lrd0Yox+JtGOpjjmY7Ep7QIJtnF1YVszQM/jkWaj4V5oJBcqtpCR
	V2y9gS7RQn6uUQDkezFSnnQN6R7x+qaU7Lp4=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

`make htmldocs` reports the following warning:

  Documentation/trace/debugging.rst: WARNING: document isn't included \
    in any toctree

Fix it by adding debugging.rst to toctree.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 Documentation/trace/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 0b300901fd75..2827292f8f34 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -36,3 +36,4 @@ Linux Tracing Technologies
    user_events
    rv/index
    hisi-ptt
+   debugging
-- 
2.34.1


