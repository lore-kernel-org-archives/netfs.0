Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2E1DB377;
	Wed, 12 Mar 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810110; cv=none; b=GlDgCRy0nKYI2CvmiPljnhy+ztb9UeCTal1gBhi1Ut9DVPliQyXG7EIbTSmh2o2Pmf68KUGgznRm0mRbcwic9Ao0VTP4HGRmJmuN0eWmexgKDE9LB7L926OVBBfWG/2nVrU6OMJq1ORLhdPmpD+Sq6inDHsEUQG/mE8A7wtfjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810110; c=relaxed/simple;
	bh=4nbhLrM4R3uCRysS/wOgPvMWhmlLUvMyPt285TlrSZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOo9ove6w4QuxnT1cgPtsHxGthqosL/M0dG2E7Bp8R9Q+2DXUojFYHykB0ZqKyTR1VoFFwf7vX7rBBG7/jyvXGTu7zyTLDM9bdsyJQjaA/x4dPOSlYwVWAHxSEkrHoazWs9j06o98k5QRYsvnrOUC+r+nTU2nyXOS/crLchdYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC6l+VBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC6l+VBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AFAC4CEEA;
	Wed, 12 Mar 2025 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741810110;
	bh=4nbhLrM4R3uCRysS/wOgPvMWhmlLUvMyPt285TlrSZg=;
	h=From:To:Cc:Subject:Date:From;
	b=IC6l+VBGXXsMnJHckbQnyRdl++3S2R+zv41eR3brzUVvUJKOIvz8XmQDXFdI+ybEB
	 D1CQvAcK0m5M6SzzYWIbfz477KMaPnlAMcqRVX8Br5LVgRNFME2ghZDOosrzR5Y4qv
	 axiTUDRpPfpaD3y0qwkYQi7kE7ROVHo2vtbuqHFvs7vvefcts0owBTULGVwdrvzwiL
	 +LOcN8vfrxfCIpRlt3PQixHW8tBU9FJXTxiyRgX0wm/w0qedj6PivPDsEe0nDfqkYm
	 qbQ+vitniFGQ0xjdaVaxp6k/xs6YRZ+fM0wlDktzceKt5LlyT84D/EltB+/KvLD4Pz
	 iswnpxvhiBXJw==
From: Kees Cook <kees@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] cachefiles: Add __nonstring annotations for unterminated strings
Date: Wed, 12 Mar 2025 13:08:26 -0700
Message-Id: <20250312200825.it.269-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=kees@kernel.org; h=from:subject:message-id; bh=4nbhLrM4R3uCRysS/wOgPvMWhmlLUvMyPt285TlrSZg=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkXX+5K3rN0gfKkmN1WLhvOncls3Ko5f5r1qW1vbip75 fr/3rgjoqOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAij1YxMny8IpN8cAVvmXHJ /XatH9cd5O8uUJl5TGBOlcd/i4ZVoi0M/x2VTQv5Q8+x8HlrOxQsOtnhm3qM68zlzaIN81c/Tlz zkRUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the array
with __nonstring to correctly identify the char array as "not a C string"
and thereby eliminate the warning:

../fs/cachefiles/key.c:12:9: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (65 chars into 64 available) [-Wunterminated-string-initialization]
   12 |         "0123456789"                    /* 0 - 9 */
      |         ^~~~~~~~~~~~

Since the array is used only for single character look-ups, use
__nonstring:

fs/cachefiles/key.c:123:                name[len++] = cachefiles_charmap[acc & 63];
fs/cachefiles/key.c:125:                name[len++] = cachefiles_charmap[acc & 63];
fs/cachefiles/key.c:127:                name[len++] = cachefiles_charmap[acc & 63];
fs/cachefiles/key.c:129:                name[len++] = cachefiles_charmap[acc & 63];

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: improve commit log
 v1: https://lore.kernel.org/lkml/20250310222402.work.925-kees@kernel.org/
Cc: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
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

