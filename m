Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8411E8359;
	Mon, 10 Mar 2025 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645447; cv=none; b=NIoQoszq5n2d9pntSyqgUvPPjFan8/Gb25omMqrbeSdsbEee1PP3MfWW5ftjfW3qUJHnBrfv9PMSzKRLxF3s3Bdoo0cRbMrWSFLFoy176xitYsQeJWWDP+vIM67pjyIgoEQuUOVVY4V+iVVIfDL3b53kAxkol0TT9MJsmvKFVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645447; c=relaxed/simple;
	bh=U+WjwQ3yEna/R5MZcY8dgC4to4hN7KZ1NERYUP5gC5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dxVVKjy/yRyQoP3xZl52xGuYuF0lbOALMUPiX4ZTwLQbUVHzPLDXokhimCWo5BU6U86b6K9ZaU5di/cVsBLhRNMsHoRJYf1sVHGL/1WXkuYqHepn06+He3ZJe9g1WiR1k2NhJh1WLArOvtZHU73ujsaukCHdvZzCyPDbk+8lo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4Bp23km; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4Bp23km"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47909C4CEE5;
	Mon, 10 Mar 2025 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645447;
	bh=U+WjwQ3yEna/R5MZcY8dgC4to4hN7KZ1NERYUP5gC5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=s4Bp23kmp/24x+roeS+rwdE3uj2N2pAo9uQPcnrWPHChFeJxRvoCJyQmWbGDrobhu
	 q4ElAJ7u6jYBx4To5jmFKzWhuqkWcDEydFN6Tn48at3GnM9KYMS9o6hXQTttX/cB9H
	 g+IOJLikJIAiMP0jVF+OcMe5Q8W0vhcJPjkYYolkJSniH0w2n2lKsFnJIgHB38CdSu
	 7Fefy7y+oapFysHbqoU92leif6bzR11mJKlNBUzJ5FgYGoO4R4fyRsyxApb/aQsegw
	 pHrjvxaMd1EwhYJzunyGQHnGz84HeXFDuP/9rmlcyXH3aycTOT/uD4N9t/nfObD2Jx
	 LtayYKTTETqxQ==
From: Kees Cook <kees@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] cachefiles: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:24:03 -0700
Message-Id: <20250310222402.work.925-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=kees@kernel.org; h=from:subject:message-id; bh=U+WjwQ3yEna/R5MZcY8dgC4to4hN7KZ1NERYUP5gC5Q=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn05p8lWqXzT24uOVuzav98+een2xUnXP55Hmdc83lJ pqHzm++1FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR6xMZ/pffmPrfVTMufbrz b+eowlOP9pk5JR0NnOvU8Wzn9x52r7WMDKun5gilXF9dFM8308TTeG7Kg2r1daKJP3qV56n6qCy M4AYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Signed-off-by: Kees Cook <kees@kernel.org>
---
 fs/cachefiles/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index bf935e25bdbe..b48525680e73 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -8,7 +8,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-static const char cachefiles_charmap[64] =
+static const char cachefiles_charmap[64] __nonstring =
 	"0123456789"			/* 0 - 9 */
 	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
-- 
2.34.1

